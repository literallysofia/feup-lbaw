<?php

namespace App\Http\Controllers;

use App\DeliveryType;
use App\Http\Controllers\Controller;
use App\Product;
use App\Purchase;
use Session;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class WishlistController extends Controller
{

    public function showWishlist(Request $request)
    {

        try {
            if(Auth::check()) {
                
                $user = Auth::user();
                $this->authorize('edit', $user);
                if(session('wishlist', NULL)) {
                    $products = $user->wishlist()->pluck('id');
                    $products_id = session('wishlist');
                    foreach($products_id as $id) {
                        foreach($products as $hasid) {
                            $id = (int) $id;
                            if($id != $hasid) {
                                $product = Product::findOrFail($id);
                                $user->wishlist()->attach($product);
                                break;
                            }
                        }
                    }
                    session()->forget('wishlist');
                    
                }
                $products = $user->wishlist()->where('is_archived', false)->get();
                
            } else {

                $products = array();
                if(session('wishlist', NULL)){
                    $products_id = session('wishlist');
                    foreach($products_id as $id) {
                        $product = Product::findOrFail($id);
                        array_push($products, $product);
                    }
                }

            }
            return view('pages.wishlist', ['products' => $products]);
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
                if($user->wishlist()->where('product_id', $request->id)->count() > 0){
                    return response(json_encode("You already have this product in your wishlist"), 401);
                }
                $user->wishlist()->attach($product);

            } else {
                if(session('wishlist', NULL)) {
                    $cookies = session('wishlist');
                    if(in_array($request->id, $cookies)){
                        return response(json_encode("You already have this product in your wishlist"), 401);
                    }
                    array_push($cookies, $request->id);
                    session(['wishlist' => $cookies]);
                }
                else {
                    $cookies = array($request->id);
                    session(['wishlist' => $cookies]);
                }
                
            }
            return response(json_encode("Product added to Wishlist"), 200);
        } else {
            return response(json_encode("That produt does not exist or it is not available"), 404);
        }

    }


    public function removeWishlistProduct(Request $request) {
        if(Auth::check()) {
        
            try {
                $user = Auth::user();
                $this->authorize('edit', $user);
                $product = $user->wishlist()->where('product_id', $request->id)->first();

            }catch(\Exception $e) {
                return response(json_encode("Error removing product from wishlist"), 500);
            }

            if($product != null){
                $user->wishlist()->detach([$request->id]);
                return response(json_encode("Product deleted from wishlist"), 200);
            }
            else{
                return response(json_encode("That produt is not on the user's wishlist"), 404);
            }
        } else {
            if(($products = session('wishlist', NULL)) != false) {
                if(in_array($request->id, $products)) {
                    $products = array_diff($products, [$request->id]);
                }
                session(['wishlist' => $products]);
                return response(json_encode("Product deleted from wishlist"), 200);
            }
        }
    }
}
