<?php

namespace App\Http\Controllers;

use App\Category;
use App\Http\Controllers\Controller;
use App\Product;

class ProductsController extends Controller
{

    public function showProducts($category_id)
    {
        try {
            $category = Category::where('id', $category_id)->first();
            $all_products = Product::where('category_id', $category->id)->get();
            $products = Product::where('category_id', $category->id)->paginate(3);

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
            if ($product != null) {
                return view('pages.product', ['product' => $product]);
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

}
