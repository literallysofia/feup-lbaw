<?php

namespace App\Http\Controllers;

use App\Category;
use App\CategoryProperty;
use App\Http\Controllers\Controller;
use App\Photo;
use App\Product;
use App\Property;
use App\Review;
use App\Value;
use App\ValuesLists;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

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
                foreach ($products->get() as $product) {
                    $brands_filter[] = $product->brand;
                }
                $brands_filter = array_unique($brands_filter);
            }

            // BASIC FILTERS //
            $sort = $request->get('sort', null);
            $price_limit = $request->get('price_limit', null);
            $brands = $request->get('brands', null);

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

            if ($brands) {
                $brand_arr = explode(',', $brands);
                $products = $products->whereIn('brand', $brand_arr);
            }

            if ($price_limit) {
                $products = $products->where('price', '<=', $price_limit);
            }

            $products = $products->paginate(9);

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        if ($request->ajax()) {
            $response = array(
                'dropdown' => view('partials.products.dropdown', ['category' => $category, 'products' => $products, 'brands' => $brands, 'price_limit' => $price_limit])->render(),
                'filters' => view('partials.products.filters', ['category' => $category, 'brands_filter' => $brands_filter, 'brands' => $brands, 'price_max' => $price_max, 'sort' => $sort, 'price_limit' => $price_limit])->render(),
                'products' => view('partials.products.product', ['products' => $products])->render(),
                'links' => view('partials.products.pagination', ['products' => $products])->render(),
                'url' => urldecode($request->fullUrl()),
                'total' => $products->total(),
            );
            return response(json_encode($response), 200);
        }

        return view('pages.products', ['category' => $category, 'products' => $products, 'brands_filter' => $brands_filter, 'price_max' => $price_max, 'sort' => $sort, 'brands' => $brands, 'price_limit' => $price_limit]);
    }

    public function showHighlights()
    {
        try {
            $products = Product::orderBy('id', 'desc')->take(8)->get();

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        return view('pages.home', ['products' => $products]);
    }

    public function searchProducts()
    {
        try {
            $keyword = Input::get('keyword');
            $products = Product::whereRaw("name @@ plainto_tsquery('" . $keyword . "')")->paginate(8);

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        return view('pages.search', ['keyword' => $keyword, 'products' => $products]);
    }

    public function showProduct($product_id)
    {

        try {
            $product = Product::findOrFail($product_id);
            $reviews = Review::where('product_id', $product_id)->orderBy('date', 'DESC')->get();
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

        if ($product == null) {
            return view('errors.404');
        }

        $category = $product->category()->first();

        $photos = Photo::where('product_id', $id)->get();

        //$properties = $product->category_properties;
        return view('pages.add_product', ['category' => $category, 'product' => $product, 'photos' => $photos]);

    }

    public function validateAddProduct(array $data)
    {

    }

    public function addProduct(Request $request)
    {

        $product = new Product;

        $category = Category::where('name', $request->category_name)->first();

        $product->category_id = $category->id;
        $product->name = $request->name;
        $product->price = $request->price;
        $product->quantity_available = $request->quantity;
        $product->brand = $request->brand;

        $product->save();

        $specs = $request->property_values;

        foreach ($specs as $spec) {
            $property = Property::where('name', $spec['property'])->first();
            $category_property = CategoryProperty::where([['category_id', $category->id], ['property_id', $property->id]])->first();
            $values_list = new ValuesLists;
            $values_list->category_property_id = $category_property->id;
            $values_list->product_id = $product->id;
            $values_list->save();
            foreach ($spec['values'] as $value) {
                $spec_value = new Value;
                $spec_value->name = $value;
                $spec_value->values_lists_id = $values_list->id;
                $spec_value->save();
            }
        }

        /*$photos_dataForm = $request->photos;
        if(count($photos_dataForm) > 0)
            foreach($photos_dataForm as $photo){

                $path = file($photo)->store('upload');

                $newPhoto = new Photo;

                $newPhoto->path = $path;
                $newPhoto->product_id = $product->id;
                $newPhoto->save();  
            }*/

        return response()->json(array('product' => $product), 200);
    }

    public function uploadImage(Request $request){
     
        $dataForm = $request->all();
        $product_id = $dataForm['id'];
        
        $new_path = $dataForm['photo']->store('public/'.$product_id);
        
        $new_path = str_replace("public","",$new_path);
        $new_path = "storage".$new_path;

        $newPhoto = new Photo;
        $newPhoto->path = $new_path;
        $newPhoto->product_id = $product_id;
        $newPhoto->save();

        return response()->json(array('count' => $dataForm['count'],'id'=>$product_id), 200);
    }

    public function editProduct($product_id,Request $request){
        
    }

    public function deleteReview(Request $request)
    {

        try {

            $user = Auth::user();
            $review = $user->reviews()->where('id', $request->id)->first();
            $product = Product::findOrFail($product_id);
            if ($product == null) {
                return response(json_encode(array('Message' => 'This product does not exist', 'Reviews' => null)), 404);
            }

            if ($review != null) {

                $review->delete();

                return response(json_encode(array('Message' => 'Review deleted', 'Reviews' => count($product->reviews))), 200);
            } else {
                return response(json_encode(array("Message" => "You can not delete this review or it does not exist", 'Reviews' => null)), 403);
            }

        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error deleting review")), 500);
        }
    }

    public function setReview(Request $request, $product_id, $review)
    {
        try {
            $product = Product::findOrFail($product_id);
            $review->title = $request->title;
            if (is_int($request->score) && $request->score >= 1 && $request->score <= 5) {
                return response(json_encode(array("Message" => "Score value is not valid")), 500);
            }
            $review->score = $request->score;
            $review->content = $request->content;
            $review->user_id = Auth::id();
            $review->product_id = $product_id;
            if ($review->save()) {
                $reviews = Review::where('product_id', $product_id)->orderBy('date', 'DESC')->get();
                foreach ($reviews as $pagereview) {
                    $pagereview->date = date('d F Y', strtotime($pagereview->date));
                    $pagereview->user->name;
                    if ($pagereview->user_id == Auth::id()) {
                        $pagereview->owner = true;
                    } else {
                        $pagereview->owner = false;
                    }

                }
                return response(json_encode(array("Message" => "Review updated", "Reviews" => $reviews, "Total" => count($product->reviews))), 200);
            } else {
                return response(json_encode(array("Message" => "Error adding/updating review")), 500);
            }
        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error adding/updating review")), 500);
        }
    }

    public function addReview(Request $request, $product_id)
    {
        try {
            $user = Auth::user();
            $product = Product::findOrFail($product_id);
            $this->authorize('review', $product);
            $review = new Review;
            return $this->setReview($request, $product_id, $review);

        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error adding review")), 500);
        }
    }

    public function updateReview(Request $request, $product_id)
    {

        try {
            $user = Auth::user();
            $review = $user->reviews()->where('id', $request->id)->first();
            return $this->setReview($request, $product_id, $review);

        } catch (\Exception $e) {
            return response(json_encode(array("Message" => "Error updating review")), 500);
        }
    }

    public function archiveProduct($product_id){
            if(Auth::user()->isAdmin()) {
                $product = Product::findOrFail($product_id);
                $product->is_archived = true;
                $product->save();
                return redirect('/');
            }
    }


}
