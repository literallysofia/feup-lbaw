<?php
namespace App\Http\Controllers;

use App\Category;
use App\CategoryProperty;
use App\Faq;
use App\Property;
use App\Purchase;
use Illuminate\Http\Request;

class AdminController extends Controller
{

    public function showAdmin()
    {

        try {
            $shipped_purchases = Purchase::where('status', 'Shipped')->orderBy('date')->get();
            $processing_purchases = Purchase::where('status', 'Processing')->orderBy('date')->get();
            $delivered_purchases = Purchase::where('status', 'Delivered')->orderBy('date')->get();            
            $properties = Property::get();
            $faqs = Faq::get();
            $categories = Category::where('is_archived', false)->get();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->setStatusCode(400);
        }

        return view('pages.admin', ['shipped_purchases' => $shipped_purchases, 'processing_purchases' => $processing_purchases, 'delivered_purchases' => $delivered_purchases,
            'properties' => $properties, 'categories' => $categories, 'faqs' => $faqs]);

    }

    public function updateAdminPurchases(Request $request){

        $purchases = json_decode($request->purchases, true);

        try {
            
            foreach ($purchases as $purchase) {

                $newpurchase = Purchase::findOrFail($purchase['purchaseId']);
                $newpurchase->status = $purchase['status'];
                $newpurchase->save();
            }

        } catch (\Exception $e) {
            //$e->getMessage();
            return response()->json(array("Message" => "Error updating purchases."), 400);        
        }

        return response()->json(array("Message" => "Purchases updated with success."), 200);      

        
    }

    public function addCategoryResponse(Request $request)
    {
        $addCategory = new Category;
        $addCategory->name = $request->categoryName;
        try {
            $addCategory->save();
        } catch (\Exception $e) {
            echo $e->getMessage();
            return response()->json(array("Message" => "Error adding category."), 400);            
        }

        if ($addCategory) {
            try {
                $newCategory = Category::where('name', $request->categoryName)->first();

            } catch (\Exception $e) {
                $e->getMessage();
                return response()->json(array("Message" => "Error adding category."), 400);
            }
        }
        else{
            return response()->json(array("Message" => "Error adding category."), 404);
        }

        return response()->json(array("Message" => "Category added with success.", 'category' => $newCategory), 200);

    }

    public function deleteCategoryResponse(Request $request)
    {

        $category = Category::findOrFail($request->categoryId);

        $category->is_archived = true;
        try {
            $category->save();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->json(array("Message" => "Error deleting category"), 400);
        }

        return response()->json(array("Message" => "Category deleted with success."), 200);
        
    }

    public function addPropertyResponse(Request $request)
    {

        $addProperty = new Property;
        $addProperty->name = $request->propertyName;
        try {
            $addProperty->save();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->json(array("Message" => "Error adding property."), 400);            
        }

        if ($addProperty) {
            try {
                $newProperty = Property::where('name', $request->propertyName)->first();

            } catch (\Exception $e) {
                $e->getMessage();
                return response()->json(array("Message" => "Error adding property."), 400);
                
            }
        } else{
            return response()->json(array("Message" => "Error adding property."), 400);            
        }

        return response()->json(array("Message" => "Property added with success.", 'property' => $newProperty), 200);

    }

    public function deletePropertyResponse(Request $request)
    {

        $property = Property::findOrFail($request->propertyId);

        try {
            $property->delete();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->json(array("Message" => "Error deleting property."), 400);
            
        }

        return response()->json(array("Message" => "Property deleted with success."), 200);

    }

    public function addCategoryPropertiesResponse(Request $request)
    {

        $category = Category::findOrFail($request->categoryId);
        $category->is_navbar_category = $request->isNavBar;
        try {
            $category->save();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->json(array("Message" => "Error saving category."), 400);            
        }

        $requestProperties = json_decode($request->categoryProperties, true);

        $propertiesIds = array();

        foreach ($requestProperties as $requestProperty) {
            $propertyId = $requestProperty['propertyId'];
            $is_required = $requestProperty['required'];

            array_push($propertiesIds, $propertyId);

            $databaseCategoryProperty = CategoryProperty::where([
                ['category_id', '=', $request->categoryId],
                ['property_id', '=', $propertyId],
            ])->get();

            //if the property doesn't exists in this category already (aka add property)
            if ($databaseCategoryProperty->isEmpty()) {

                $addCategoryProperty = new CategoryProperty;
                $addCategoryProperty->category_id = $request->categoryId;
                $addCategoryProperty->property_id = $propertyId;
                $addCategoryProperty->is_required_property = $is_required;

                try {
                    $addCategoryProperty->save();
                } catch (\Exception $e) {
                    echo $e->getMessage();
                    return response()->json(array("Message" => "Error saving category."), 400);                    
                }
            }

            //the property already exists (aka update property)
            else {
                if ($databaseCategoryProperty->first()->is_required_property != $is_required) {
                    try {
                        $databaseCategoryPropertyId = $databaseCategoryProperty->first()->id;
                        CategoryProperty::find($databaseCategoryPropertyId)->update(['is_required_property' => $is_required]);
                    } catch (\Exception $e) {
                        echo $e->getMessage();
                        return response()->json(array("Message" => "Error saving category."), 400);
                    }
                }

            }

        }

        return response()->json(array("Message" => "Category saved with success.", 'category' => $category), 200);

    }

    public function addFaq(Request $request)
    {

        $addFaq = new Faq;
        $addFaq->question = $request->question;
        $addFaq->answer = $request->answer;
        
        try {
            $addFaq->save();
        } catch (\Exception $e) {
            echo $e->getMessage();
        }

        if ($addFaq) {
            try {
                $newFaq = Faq::where([['question', $request->question],['answer', $request->answer]])->first();
            } catch (\Exception $e) {
                $e->getMessage();
            }
        }

        return response()->json(array("Message" => "FAQ added with success.",'faq' => $newFaq), 200);

    }

    public function deleteFaq(Request $request)
    {

        try {

            $faq = Faq::findOrFail($request->faqId);

            if($faq!=null){
                $faq->delete();
                return response()->json(array("Message" => "FAQ deleted with success."), 200);
            }
            else{
                return response(json_encode(array("Message" => "You can not delete this FAQ or it does not exist.")), 404);                
            }

       
        } catch (\Exception $e) {
            return response()->json(array("Message" => $e->getMessage()), 400);
        }

        

    }






}