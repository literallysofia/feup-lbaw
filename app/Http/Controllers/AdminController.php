<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Support\Facades\Validator;


use App\User;
use App\Country;
use App\City;
use App\Purchase;
use App\Property;
use App\Category;
use App\Faq;



class AdminController extends Controller{

    public function showAdmin(){


        try {
            $shipped_purchases = Purchase::where('status','Shipped')->orderBy('date')->get();
            $processing_purchases = Purchase::where('status','Processing')->orderBy('date')->get();
            $properties=Property::get();
            $faqs=Faq::get();
            $categories=Category::where('is_archived', false)->get();
        }catch(\Exception $e) {
            $e->getMessage();
            return response()->setStatusCode(400);
        }

        return view('pages.admin',['shipped_purchases'=> $shipped_purchases, 'processing_purchases'=> $processing_purchases,
        'properties'=>$properties, 'categories' => $categories,'faqs'=>$faqs] );
        
    }

    public function addCategoryResponse(Request $request){
        $addCategory = new Category;
        $addCategory->name = $request->categoryName;
        try {
            $addCategory->save();
        }catch(\Exception $e) {
            echo $e->getMessage();
        }

        if($addCategory){
            try {
                $newCategory = Category::where('name',$request->categoryName)->first();
        
            }catch(\Exception $e) {
                $e->getMessage();
            }
        }

        return response()->json(array('category'=> $newCategory), 200);

    }

    public function deleteCategoryResponse(Request $request){

        $category = Category::findOrFail($request->categoryId);

        $category->is_archived = true;
        try {
         $category->save();
        }catch(\Exception $e) {
            $e->getMessage();
        }
    }

}



?>