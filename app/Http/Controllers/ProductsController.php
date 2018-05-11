<?php

namespace App\Http\Controllers;

use App\Category;
use App\Http\Controllers\Controller;
use App\Product;
use App\Review;
use Illuminate\Http\Request;

class ProductsController extends Controller
{

    public function showProducts(Request $request, $category_id)
    {
        try {
            $category = Category::where('id', $category_id)->first();
            $all_products = Product::where('category_id', $category->id);
            $price_max = $all_products->max('price');

            $sort = $request->get('sort', null);
            $price_limit = $request->get('price_limit', null);

            $query = $all_products;

            if ($sort) {
                switch ($sort) {
                    case 1:
                        $query = $query->orderBy('price', 'asc');
                        break;
                    case 2:
                        $query = $query->orderBy('price', 'desc');
                        break;
                    case 3:
                        $query = $query->orderBy('score', 'desc');
                        break;
                }
            }

            if ($price_limit) {
                $query = $query->where('price', '<=', $price_limit);
            }

            $products = $query->paginate(3)->appends([
                'sort' => request('sort'),
                'price_limit' => request('price_limit'),
            ]);

            $brands = array();
            foreach ($all_products->get() as $product) {
                $brands[] = $product->brand;
            }
            $brands = array_unique($brands);

        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        if ($request->ajax()) {
            $response = array(
                'dropdown' => view('partials.products.dropdown', ['category' => $category, 'products' => $products, 'price_limit' => $price_limit])->render(),
                'filters' => view('partials.products.filters', ['category' => $category, 'brands' => $brands, 'price_max' => $price_max, 'sort' => $sort, 'price_limit' => $price_limit])->render(),
                'products' => view('partials.products.product', ['products' => $products])->render(),
                'links' => view('partials.products.pagination', ['products' => $products])->render(),
                'url' => $request->fullUrl(),
            );
            return response(json_encode($response), 200);
        }

        return view('pages.products', ['category' => $category, 'products' => $products, 'brands' => $brands, 'price_max' => $price_max, 'sort' => $sort, 'price_limit' => $price_limit]);
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

    public function deleteReview(Request $request)
    {

        try {
            $user = Auth::user();
            $review = $user->reviews->where('id', $request->id)->first();
            if ($review != null) {
                $review->delete();
                $product = Product::findOrFail($request->product_id);
                return response(json_encode(array('Message' => 'Review deleted', 'Reviews' => count($product->reviews))), 200);
            } else {
                return response(json_encode(array("Message" => "You can not delete this review or it does not exist", 'Reviews' => null)), 404);
            }

        } catch (\Exception $e) {
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
