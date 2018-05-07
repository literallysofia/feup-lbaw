<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Support\Facades\Validator;


use App\Category;


class AdminController extends Controller{

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
        
        
    }

}



?>