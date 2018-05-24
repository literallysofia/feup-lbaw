<?php

namespace App\Http\Controllers;

use App\Category;
use App\Http\Controllers\Controller;
use App\Product;
use App\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

class ProductsController extends Controller
{

    public function showProducts(Request $request, $category_id)
    {
        try {
            // GENERAL DATA //
            $category = Category::where('id', $category_id)->first();
            $products = Product::where('category_id', $category->id);
            $price_max = $products->max('price');

            if (!empty($products)) {

                $properties_filter = [];

                // BRAND AND REQUIRED PROPERTIES//
                foreach ($category->properties()->get() as $property) { //get required properties from category
                    $required_properties[] = $property->category_properties->where('category_id', $category->id)->where('is_required_property', 'true')->first()['property_id'];
                }

                foreach ($products->get() as $product) {
                    $brands_filter[] = $product->brand;

                    foreach ($product->category_properties()->get() as $property) { //get required properties values
                        if (in_array($property->property->id, $required_properties)) {
                            $property_values = $property->values_lists->where('product_id', $product->id)->first()->values;
                            foreach ($property_values as $value) {
                                $properties_filter[$property->property->name][] = $value->name;
                            }
                        }
                    }
                }

                $brands_filter = array_unique($brands_filter);

                foreach ($properties_filter as $key => $values) { //remove repeated values
                    $values = array_unique($values);
                    $properties_filter[$key] = $values;
                }
            }

            // BASIC FILTERS //
            $sort = $request->get('sort', null);
            $price_limit = $request->get('price_limit', null);
            $brands = $request->has('brands') ? json_decode($request->brands) : null;
            $properties = $request->has('properties') ? json_decode($request->properties) : null;

            // APPLY QUERIES //
            if ($sort) {
                switch ($sort) {
                    case 1:
                        $products = $products->orderBy('price', 'asc');
                        break;
                    case 2:
                        $products = $products->orderBy('price', 'desc');
                        break;
                    case 3:
                        $products = $products->orderBy('score', 'desc');
                        break;
                }
            }

            if (!empty($brands)) {
                $products = $products->whereIn('brand', $brands);
            }

            /*if (!empty($properties)) {
            foreach ($properties as $key => $values) {
            $products = $products->values_lists->whereIn($key, $values);
            }
            }*/

            if ($price_limit) {
                $products = $products->where('price', '<=', $price_limit);
            }

            $products = $products->paginate(3)->appends([
                'sort' => request('sort'),
                'brands' => request('brands'),
                'price_limit' => request('price_limit'),
            ]);

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        if ($request->ajax()) {
            $response = array(
                'dropdown' => view('partials.products.dropdown', ['category' => $category, 'products' => $products, 'brands' => $brands, 'price_limit' => $price_limit])->render(),
                'filters' => view('partials.products.filters', ['category' => $category, 'brands_filter' => $brands_filter, 'properties_filter' => $properties_filter, 'brands' => $brands, 'properties' => $properties, 'price_max' => $price_max, 'sort' => $sort, 'price_limit' => $price_limit])->render(),
                'products' => view('partials.products.product', ['products' => $products])->render(),
                'links' => view('partials.products.pagination', ['products' => $products])->render(),
                'url' => $request->fullUrl(),
            );
            return response(json_encode($response), 200);
        }

        return view('pages.products', ['category' => $category, 'products' => $products, 'brands_filter' => $brands_filter, 'properties_filter' => $properties_filter, 'price_max' => $price_max, 'sort' => $sort, 'brands' => $brands, 'price_limit' => $price_limit]);
    }

    public function showProduct($product_id)
    {

        try {
            $product = Product::findOrFail($product_id);

            $reviews = Review::where('product_id', $product_id)->paginate(2);

            if ($product != null) {
                return view('pages.product', ['product' => $product, 'reviews' => $reviews]);
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
            $category = Category::where('name', $category_name)->first();
        } catch (\Exception $e) {
            $e->getMessage();
            return response()->setStatusCode(400);
        }
        return view('pages.add_product', ['category' => $category, 'photos' => null, 'product' => null]);
    }

    public function showEditProduct($id)
    {

        $product = Product::where('id', $id)->first();
        $category = $product->category()->first();

        $photos = Photo::where('product_id', $id)->get();

        $properties = $category->properties()->get();
        return view('pages.add_product', ['category_name' => $category->name, 'product' => $product, 'photos' => $photos, 'properties' => $properties]);

    }

    public function deleteReview(Request $request)
    {

        try {
            $user = Auth::user();
            $review = $user->reviews->where('id', $request->id)->first();
            $product = Product::findOrFail($request->product_id);
            if($product == null)
                return response(json_encode(array('Message'=>'This product does not exist', 'Reviews'=>null)), 404);
            if($review != null){
                $review->delete();
                return response(json_encode(array('Message'=>'Review deleted', 'Reviews'=>count($product->reviews))), 200);
            } else
                return response(json_encode(array("Message"=>"You can not delete this review or it does not exist", 'Reviews'=>null)), 404);
       }catch(\Exception $e){
           return response(json_encode($e->getMessage()), 400);
       }
       
    }

    public function addReview(Request $request, $product_id)
    {

        try {
            $user = Auth::user();
            $product = Product::findOrFail($product_id);
            $this->authorize('review', $product_id);
            $review = new Review();
            $review->title = $request->title;
            if (is_int($request->score) && $request->score >= 1 && $request->score <= 5) {
                return response(json_encode(array("Message" => "Score value is not valid", "Content" => null)), 400);
            }
            $review->score = $request->score;
            $review->content = $request->content;
            if ($review->save()) {
                return response(json_encode(array("Message" => "Review added", "Content" => $review)), 200);
            } else {
                return response(json_encode(array("Message" => "Error adding review", "Content" => null)), 400);
            }
        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error adding review", "Content" => null)), 400);
        }
    }

}
