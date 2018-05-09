<?php

namespace App\Http\Controllers;

use App\Category;
use App\Http\Controllers\Controller;
use App\Product;
use App\Property;
use App\Review;
use Illuminate\Http\Request;

class ProductsController extends Controller
{

    public function showProducts(Request $request, $category_id)
    {
        try {
            $category = Category::where('id', $category_id)->first();
            $all_products = Product::where('category_id', $category->id)->get();

            $sort = $request->get('sort', null);

            $products = Product::where('category_id', $category->id)->when($sort, function ($query) use ($sort) {
                switch ($sort) {
                    case 1:
                        $query->orderBy('price', 'asc');
                        break;
                    case 2:
                        $query->orderBy('price', 'desc');
                        break;
                    case 3:
                        $query->orderBy('score', 'desc');
                        break;
                }
            })->paginate(3);

            $brands = array();
            foreach ($all_products as $product) {
                $brands[] = $product->brand;
            }
            $brands = array_unique($brands);

            $max_price = $all_products->max('price');

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }
        return view('pages.products', ['category' => $category, 'products' => $products, 'brands' => $brands, 'max_price' => $max_price]);
    }

    public function showProduct($product_id)
    {

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

    public function showAddProduct($category_name)
    {
        try {
            $category = Category::where('name', $category_name);
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->setStatusCode(400);
        }
        return view('pages.add_product', ['category_name' => $category_name]);
    }

    public function showEditProduct($id)
    {

        $product = Product::where('id', $id)->first();
        $category = $product->category()->first();

        $photos = Photo::where('product_id', $id)->get();

        $properties = $category->properties()->get();
        return view('pages.add_product', ['category_name' => $category->name, 'product' => $product, 'photos' => $photos, 'properties' => $properties]);

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
