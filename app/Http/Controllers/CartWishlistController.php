<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;
use App\DeliveryType;


class CartWishlistController extends Controller{

    public function showWishlist(){
        
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $products = $user->wishlist()->get();
            return view('pages.wishlist', ['products' => $products]);
        }catch(\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
        
    }

    public function removeWishlistProduct(Request $product_id) {
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->wishlist()->where('product_id', $product_id->id)->first();

        }catch(\Exception $e) {
            return response(json_encode($e.getMessage()), 400);
        }

        if($product != null){
            $product->delete();
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
            return view('pages.cart', ['products' => $products, 'addresses' => $addresses, 'delivery_types'=> $delivery_types]);
        }catch(\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
        
    }

    public function addCartProduct(Request $product_id) {
        
        try {
            $user = Auth::user();
            $this->authorize('edit', $user);
            $product = $user->wishlist()->where('product_id', $product_id->id)->first();

        }catch(\Exception $e) {
            return response(json_encode($e.getMessage()), 400);
        }

        if($product != null){
            $user->cart()->attach($product, array('quantity'=>1));
            return response(json_encode("Product added to Cart"), 200);
        }
        else{
            return response(json_encode("That produt is not on the user's wishlist"), 404);
        }

    }

    public function __construct() {
        $this->middleware('auth');
    }

}

?>