@extends('layouts.app')
@section('content')
@include('partials.breadcrumbs', $data = array('FAQs' => ''))
<main>

<h6>> PRODUCT -> CATEGORY_PROPERTY <h6>
<h6> {{$product->id}} <h6>
<h6> {{$product->name}} <h6>
@foreach($product->category_properties as $c_p)
    <p> {{$c_p->id}} </p>
@endforeach

<h6>> PRODUCT -> VALUES_LISTS <h6>
<h6> {{$product->id}} <h6>
<h6> {{$product->name}} <h6>
@foreach($product->values_lists as $pvl)
    <p> {{$pvl->id}} </p>
@endforeach

<h6>VL->product</h6>
<p>{{$product->values_lists->get(0)->product->id}}</p>

<h6>> CATEGORY_PROPERTY -> PRODUCT <h6>
@foreach($categoryproperty->products as $p)
    <p> {{$p->id}} </p>
@endforeach

<h6>> CATEGORY_PROPERTY -> VALUES_LISTS <h6>
@foreach($categoryproperty->values_lists as $cpvl)
    <p> {{$cpvl->id}} </p>
@endforeach

<h6>VL->CP</h6>
<p>{{$categoryproperty->values_lists->get(0)->category_property->id}}</p>

<h6>> CATEGORY -> PROPERTIES <h6>
<h6> {{$category->id}} <h6>
<h6> {{$category->name}} <h6>
@foreach($category->properties as $cproperty)
    <p> {{$cproperty->id}} </p>
@endforeach


<h6>> PROPERTY -> CATEGORIES <h6>
<h6> {{$property->id}} <h6>
<h6> {{$property->name}} <h6>
@foreach($property->categories as $pcategory)
    <p> {{$pcategory->id}} </p>
@endforeach

<h6>> PROPERTY -> CATEGORY_PROPERTY <h6>
<h6> {{$property->id}} <h6>
<h6> {{$property->name}} <h6>
@foreach($property->category_properties as $pcp)
    <p> {{$pcp->id}} </p>
@endforeach


<div class="container">
            <h1>Frequently Asked Questions</h1>
            
            <div class="section-container faq">
                @foreach ($faqs as $faq) 
                    <div class="question">
                        <p class="font-weight-bold">{{$faq->question}}</p>
                        <p> {{$faq->answer}} </p>
                    </div>
                @endforeach
            </div>
</div>
</main>
@endsection