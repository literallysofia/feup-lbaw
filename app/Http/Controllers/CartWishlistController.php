<?php

namespace App\Http\Controllers;

use App\DeliveryType;
use App\Http\Controllers\Controller;
use App\Product;
use App\Purchase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CartWishlistController extends Controller
{

    public function showWishlist(Request $request)
    {

        try {
            if (Auth::check()) {
                $user = Auth::user();
                $this->authorize('edit', $user);
                $products = $user->wishlist()->get();
                return view('pages.wishlist', ['products' => $products]);

            } else {
                $request->cookie('name');
            }
        } catch (\Exception $e) {
            return response(json_encode("Error showing wishlist"), 500);
        }

    }

    public function addWishlistProduct(Request $request)
    {

        try {
            $product = Product::findOrFail($request->id);
        } catch (\Exception $e) {
            return response(json_encode("Error getting product"), 500);
        }

        if ($product != null) {

            if (Auth::check()) {

                $user = Auth::user();
                $this->authorize('edit', $user);
                if ($user->wishlist()->where('product_id', $request->id)->count() > 0) {
                    return response(json_encode("You already have this product in your wishlist"), 500);
                }
                $user->wishlist()->attach($product);

            } else {

            }
            return response(json_encode("Product added to Wishlist"), 200);
        } else {
            return response(json_encode("That produt does not exist or it is not available"), 404);
        }

    }

    public function removeWishlistProduct(Request $request)
    {
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->wishlist()->where('product_id', $request->id)->first();

        } catch (\Exception $e) {
            return response(json_encode("Error removing product from wishlist"), 500);
        }

        if ($product != null) {
            $user->wishlist()->detach([$request->id]);
            return response(json_encode("Product deleted from wishlist"), 200);
        } else {
            return response(json_encode("That produt is not on the user's wishlist"), 404);
        }
    }

    public function showCart()
    {

        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $products = $user->cart()->get();
            $total = $products->sum(function ($t) {
                return $t->price * $t->pivot->quantity;
            });
            $addresses = $user->addresses()->get();
            $delivery_types = DeliveryType::get();
            return view('pages.cart', ['total' => $total, 'products' => $products, 'addresses' => $addresses, 'delivery_types' => $delivery_types]);
        } catch (\Exception $e) {
            return response(json_encode("Error showing cart"), 500);
        }

    }

    public function addCartProduct(Request $request)
    {

        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = Product::findOrFail($request->id);
            if ($user->cart()->where('product_id', $request->id)->count() > 0) {
                return response(json_encode("You already have this product in your cart"), 500);
            }

        } catch (\Exception $e) {
            return response(json_encode("Error adding product to cart"), 400);
        }

        if ($product != null) {
            $user->cart()->attach($product, array('quantity' => 1));
            return response(json_encode("Product added to Cart"), 200);
        } else {
            return response(json_encode("That produt does not exist or it is not available"), 404);
        }

    }

    public function removeCartProduct(Request $request)
    {
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->cart()->where('product_id', $request->id)->first();

        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error removing product from cart", "Price" => null)), 500);
        }

        if ($product != null) {
            $user->cart()->detach([$request->id]);
            $products = $user->cart()->get();
            $total = $products->sum(function ($t) {
                return $t->price * $t->pivot->quantity;
            });
            return response(json_encode(array("Message" => "Product deleted from cart", "Price" => $total)), 200);
        } else {
            return response(json_encode(array("Message" => "That produt is not in your cart", "Price" => null)), 404);
        }
    }

    public function updateCartProduct(Request $request)
    {

        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->cart()->where('product_id', $request->id)->first();

        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error updating product from cart", "Price" => null)), 400);
        }

        if ($product != null) {

            try {
                $product->pivot->quantity = intval($request->quantity);
                $product->pivot->update();
                $products = $user->cart()->get();
                $total = $products->sum(function ($t) {
                    return $t->price * $t->pivot->quantity;
                });
                return response(json_encode(array("Message" => "Your product quantity was updated", "Price" => $total)), 200);
            } catch (\Exception $e) {
                return response(json_encode(array('Message' => "There is not enough available products", "Price" => null)), 500);
            }

        }
    }

    public function checkout(Request $request)
    {

        try {
            if (!Auth::check()) {
                return response(json_encode("You are not able to checkout"), 401);
            }

            $user = Auth::user();
            $address = $user->addresses()->where('address_id', $request->delivery_address);
            $delivery = DeliveryType::findOrFail($request->delivery_type);
            $products_cart = $user->cart()->get();
            $total = $products_cart->sum(function ($t) {
                return $t->price * $t->pivot->quantity;
            });
            $total = number_format($total + $delivery->price, 2, '.', '');
            if ($delivery == null || $address == null || $total != number_format($request->total_price, 2, '.', '')) {
                return response(json_encode("Something went wrong checking out"), 500);
            }

            DB::transaction(function () use ($total, $request, $products_cart) {

                $purchase = new Purchase;
                $purchase->user_id = Auth::id();
                $purchase->total = $total;
                $purchase->address_id = $request->delivery_address;
                $purchase->delivery_type_id = $request->delivery_type;
                $purchase->save();
                $purchase_products = [];
                foreach ($products_cart as $product) {
                    $product_info = array('quantity' => $product->pivot->quantity, 'price' => number_format($product->price, 2, '.', ''));
                    $purchase_products[$product->id] = $product_info;
                }
                $purchase->products()->sync($purchase_products, false);

            });

            return redirect()->to(route('profile', [Auth::id()]) . '#onhold_title');

        } catch (\Exception $e) {
            return response(json_encode("Something went wrong checking out"), 500);
        }
    }

    public function __construct()
    {
        $this->middleware('auth');
    }

}
