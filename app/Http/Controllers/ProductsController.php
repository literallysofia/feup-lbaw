<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;

use App\Category;

class ProductsController extends Controller {

    public function showProducts($category_name) {
        try {
            $category = Category:: where('name', $category_name);
        } catch (\Exception $e) {
            $e -> getMessage();
            return response() -> setStatusCode(400);
        }
        return view('pages.products', ['category_name'=>$category_name,'category'=> $category]);
    }

}

?>