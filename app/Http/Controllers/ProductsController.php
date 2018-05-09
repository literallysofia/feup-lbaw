<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;

use App\Category;
use App\Product;
use App\Property;
use App\Review;

class ProductsController extends Controller {

    public function showProducts($category_id) {
        try {
            $category = Category::findOrFail($category_id)->first();
            $products = Product::where('category_id', $category->id)->paginate(3);
        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
        return view('pages.products', ['category'=>$category, 'products'=>$products]);
    }

    public function showProduct($product_id) {

        try {
            $product = Product::findOrFail($product_id);

            $reviews = Review::where('product_id', $product_id)->paginate(2);
            
            if($product != null) {
                return view('pages.product', ['product'=>$product, 'reviews'=>$reviews]);
            } else {
                return response(json_encode("This product does not exist"), 404);
            }
        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
    }
    
    public function showAddProduct($category_name){
        try{
            $category = Category::where('name',$category_name);
        }catch(\Exception $e){
            $e -> getMessage();
            return response() -> setStatusCode(400);
        }
        return view('pages.add_product',['category_name'=>$category_name]);
    }

    public function showEditProduct($id){

        $product = Product::where('id',$id)->first();
        $category = $product->category()->first();

        $photos = Photo::where('product_id',$id)->get();

        $properties = $category->properties()->get();
        return view('pages.add_product',['category_name'=>$category->name,'product'=>$product,'photos'=>$photos,'properties' =>$properties]);
        

    }

    public function deleteReview(Request $request) {

       try {
            $user = Auth::user();
            $review = $user->reviews->where('id', $request->id)->first();
            if($review != null){
                $review->delete();
                $product = Product::findOrFail($request->product_id);
                return response(json_encode(array('Message'=>'Review deleted', 'Reviews'=>count($product->reviews))), 200);
            } else
                return response(json_encode(array("Message"=>"You can not delete this review or it does not exist", 'Reviews'=>null)), 404);
       }catch(\Exception $e){
           return response(json_encode($e->getMessage()), 400);
       }
       
    }

    public function addReview($product_id, Request $request) {

        try {
            $user = Auth::user();
            $product = Product::findOrFail($product_id);
            $this->authorize('review', $product_id);
            $review = new Review();
            $review->title = $request->title;
            if(is_int($request->score) && $request->score >= 1 && $request->score <= 5) {
                return response(json_encode(array("Message"=>"Score value is not valid", "Content"=>null)), 400);
            }
            $review->score = $request->score;
            $review->content = $request->content;
            if($review->save()) {
                return response(json_encode(array("Message"=>"Review added", "Content"=>$review)), 200);
            } else {
                return response(json_encode(array("Message"=>"Error adding review", "Content"=>null)), 400);
            }
        }catch(\Exception $e) {
            return response(json_encode(array("Message"=>"Error adding review", "Content"=>null)), 400);
        }
    }

}

?>