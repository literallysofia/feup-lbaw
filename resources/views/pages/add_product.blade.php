@extends('layouts.app')

@section('title','New Product')

@section('content')

@include('partials.breadcrumbs', $data = array('Management Area' => '','Add/Edit Product' => ''))


<main>
<div class="container">
            <div class="container scroll_nav">
                <div class="row">
                    <h1 class="col-12">
                        {{$category_name}}
                    </h1>
                </div>
            </div>
        </div>


        <div class="container">
            <section class="mt-5">
                <h2>Basic Information</h2>

                <div class="section-container">
                    <form>
                        <div class="form-group">
                            <label for="product_name">Name</label>
                        @if($product != null)
                        <input type="text" class="form-control" id="product_name" placeholder="{{$product->name}}">
                        @else
                        <input type="text" class="form-control" id="product_name" placeholder="Product Name">
                        </div>
                        <div class="form-group">
                            <label for="add_product_price">Price</label>
                        @if($product != null)
                        <input type="text" class="form-control" id="add_product_price" placeholder="{{$product->price}}">
                        @else
                        <input type="text" class="form-control" id="add_product_price" placeholder="Product Price">
                        </div>
                        <div class="form-group">
                            <label for="product_quantity">Quantity</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="product_quantity" placeholder="{{$product->quantity}}">
                            @else
                            <input type="text" class="form-control" id="product_quantity" placeholder="Poduct Quantity">
                        </div>
                        <div class="form-group">
                            <label for="product_brand">Brand</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="product_brand" placeholder="{{$product->brand}}">
                            @else
                            <input type="text" class="form-control" id="product_brand" placeholder="Product Brand">
                        </div>
                    </form>
                </div>

            </section>
        </div>

        <div class="container">
            <section class="mt-5">
                <h2>Photos</h2>

                <div class="cards photo-cards row">
                    @each('partials.add_photo',$photos,'photo')
                    <div class="mt-4 col-md-6 col-lg-3">
                        <div class="box d-flex flex-column last-card">
                            Add Photo
                        </div>
                    </div>
                </div>

            </section>
        </div>

        <div class="container">
            <section class="mt-5">
                <h2>Tech Specs</h2>

                <div class="cards specs-cards row">
                    @each('partials.add_spec',$properties,'property')           
                </div>

            </section>

            <div id="save_product_button" class="d-flex flex-column">
                <input type="button" class="black-button mt-2 ml-auto" value="Save" </input>
            </div>
</div>

</main>



@endsection