<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;
use App\DeliveryType;

use App\Product;

class CartWishlistController extends Controller{

    public function showWishlist(Request $request){
        
        try {
            if(Auth::check()) {
                $user = Auth::user();
                $this->authorize('edit', $user);
                $products = $user->wishlist()->get();
                return view('pages.wishlist', ['products' => $products]);

            } else {
                $request->cookie('name');
            }
        }catch(\Exception $e) {
            return response(json_encode("Error showing wishlist"), 400);
        }
        
    }

    public function addWishlistProduct(Request $request) {
        
        try {
            $product = Product::findOrFail($request->id);
        }catch(\Exception $e) {
            return response(json_encode("Error getting product"), 400);
        }

        if($product != null){

            if(Auth::check()) {

                $user = Auth::user();
                $this->authorize('edit', $user);
                if($user->wishlist()->where('product_id', $request->id)->count() > 0){
                    return response(json_encode("You already have this product in your wishlist"), 400);
                }
                $user->wishlist()->attach($product);

            } else {


            }
            return response(json_encode("Product added to Wishlist"), 200);
        }
        else{
            return response(json_encode("That produt does not exist or it is not available"), 404);
        }

    }


    public function removeWishlistProduct(Request $request) {
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->wishlist()->where('product_id', $request->id)->first();

        }catch(\Exception $e) {
            return response(json_encode("Error removing product from wishlist"), 400);
        }

        if($product != null){
            $user->wishlist()->detach([$request->id]);
            return response(json_encode("Product deleted from wishlist"), 200);
        }
        else{
            return response(json_encode("That produt is not on the user's wishlist"), 404);
        }
    }

    public function showCart(){
        
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $products = $user->cart()->get();
            $addresses = $user->addresses()->get();
            $delivery_types = DeliveryType::get();
            return view('pages.cart', ['products' => $products,'addresses' => $addresses, 'delivery_types'=> $delivery_types]);
        }catch(\Exception $e) {
            return response(json_encode("Error showing cart"), 400);
        }
        
    }

    public function addCartProduct(Request $request) {
        
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = Product::findOrFail($request->id);
            if($user->cart()->where('product_id', $request->id)->count() > 0){
                return response(json_encode("You already have this product in your cart"), 400);
            }

        }catch(\Exception $e) {
            return response(json_encode("Error adding product to cart"), 400);
        }

        if($product != null){
            $user->cart()->attach($product, array('quantity'=>1));
            return response(json_encode("Product added to Cart"), 200);
        }
        else{
            return response(json_encode("That produt does not exist or it is not available"), 404);
        }

    }

    public function removeCartProduct(Request $request) {
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->cart()->where('product_id', $request->id)->first();

        }catch(\Exception $e) {
            return response(json_encode(array("Message"=>"Error removing product from cart", "Price"=>null)), 400);
        }

        if($product != null){
            $user->cart()->detach([$request->id]);
            $products = $user->cart();
            $total = $products->sum('price');
            return response(json_encode(array("Message"=>"Product deleted from cart", "Price"=>$total)), 200);
        }
        else{
            return response(json_encode(array("Message"=>"That produt is not in your cart", "Price"=>null)), 404);
        }
    }

    public function __construct() {
        $this->middleware('auth');
    }

}

?>