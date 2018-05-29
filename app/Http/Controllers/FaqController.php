<?php

namespace App\Http\Controllers;

use App\Category;
use App\CategoryProperty;
use App\Faq;
use App\Http\Controllers\Controller;
use App\Product;
use App\Property;

class FaqController extends Controller
{

    public function showFaqs()
    {

        try {
            $faqs = Faq::get();
            $product = Product::findOrFail(5);
            $category = Category::findOrFail(3);
            $property = Property::findOrFail(2);
            $categoryproperty = CategoryProperty::findOrFail(4);
        } catch (\Exception $e) {
            $e->getMessage();
            redirect('erros/404');
        }
        return view('pages.faq', ['faqs' => $faqs, 'product' => $product, 'category' => $category, 'property' => $property, 'categoryproperty' => $categoryproperty]);
    }

}
