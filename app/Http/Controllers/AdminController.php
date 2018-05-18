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
use App\CategoryProperty;
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


    public function addPropertyResponse(Request $request){
       
        $addProperty = new Property;
        $addProperty->name = $request->propertyName;
        try {
            $addProperty->save();
        }catch(\Exception $e) {
            echo $e->getMessage();
        }

        if($addProperty){
            try {
                $newProperty = Property::where('name',$request->propertyName)->first();
        
            }catch(\Exception $e) {
                $e->getMessage();
            }
        }

        return response()->json(array('property'=> $newProperty), 200);

    }

    public function deletePropertyResponse(Request $request){

        $property = Property::findOrFail($request->propertyId);

        try {
         $property->delete();
        }catch(\Exception $e) {
            $e->getMessage();
        }

        return response()->json('Success', 200);
    
    }

    public function addCategoryPropertiesResponse(Request $request){
      
        $category = Category::findOrFail($request->categoryId);
        $category->is_navbar_category = $request->isNavBar;
        try {
            $category->save();
        }catch(\Exception $e) {
            $e->getMessage();
        }


        $requestProperties = json_decode($request->categoryProperties, true);
        
        $propertiesIds = array();

        foreach($requestProperties as $requestProperty){
            $propertyId = $requestProperty['propertyId'];
            $is_required = $requestProperty['required'];

            array_push($propertiesIds, $propertyId);

            $databaseCategoryProperty = CategoryProperty::where([
                ['category_id', '=', $request->categoryId],
                ['property_id', '=',  $propertyId]
            ])->get();
            
            //if the property doesn't exists in this category already (aka add property)
            if($databaseCategoryProperty->isEmpty()){

                $addCategoryProperty = new CategoryProperty;
                $addCategoryProperty->category_id = $request->categoryId;
                $addCategoryProperty->property_id = $propertyId;
                $addCategoryProperty->is_required_property = $is_required;
                
                try {
                    $addCategoryProperty->save();
                }catch(\Exception $e) {
                    echo $e->getMessage();
                }
            }
            
            //the property already exists (aka update property)
            else{
                if($databaseCategoryProperty->first()->is_required_property != $is_required){
                    try {
                        $databaseCategoryPropertyId = $databaseCategoryProperty->first()->id;
                        CategoryProperty::find($databaseCategoryPropertyId)->update(['is_required_property' => $is_required]);
                    }catch(\Exception $e) {
                        echo $e->getMessage();
                    }
                }

            }
           
        }


        return response()->json(array('category'=> $category, 200));
    
    }

}

?>