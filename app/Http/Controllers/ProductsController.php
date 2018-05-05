<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;

use App\Category;
use App\Product;

class ProductsController extends Controller {

    public function showProducts($category_name) {
        try {
            $category = Category::where('name', $category_name);
        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
        return view('pages.products', ['category_name'=>$category_name,'category'=> $category]);
    }

    public function showProduct($product_id) {

        try {
            $product = Product::findOrFail($product_id);
            if($product != null) {
                return view('pages.product', ['product'=>$product]);
            } else {
                return response(json_encode("This product does not exist"), 404);
            }
        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
    }

}

?>