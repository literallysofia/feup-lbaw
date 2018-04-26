<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;


class ProductsController extends Controller{

    public function showProducts($category_id) {
        $category = Categories::findOrFail($category_id);
      try {
          $products = Products::where('category_id', $category_id)->get();

        $purchases = $user->purchases()->get();
        $addresses = $user->addresses()->where('is_archived',false)->get();
        $countries = Country::get();
        $cities = City::get();
      }catch(\Exception $e) {
        $e->getMessage();
        return response()->setStatusCode(400);
      }

        try {
            $faqs = DB::table('faqs')->get();
        }catch(\Exception $e) {
            $e->getMessage();
            redirect('erros/404');
        }
        return view('pages.faq',['faqs'=>$faqs]);
    }

}

?>