@extends('layouts.app')

@section('title', 'Sweven | Add Product')

@section('content')

@include('partials.breadcrumbs', $data = array('Management Area' => 'admin','Add/Edit Product' => ''))

<script src={{ asset('js/addProduct.js') }} defer></script>

<main>
    <div class="container">
        <div class="container scroll_nav">
            <div class="row">
                <h1 class="col-12" id="category_name">{{$category->name}}</h1>
            </div>
        </div>
    </div>
    <div class="container">
        <section class="mt-5">
            <h2>Basic Information</h2>
            <div class="section-container">
            <div class="alert alert-danger" id="basic-error" style="display:none"></div>
                <form id="requiredForm">
                    <fieldset>
                        <div class="form-group">
                            <label for="product_name">Name</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="product_name" value="{{$product->name}}" required>
                            @else
                            <input type="text" class="form-control" id="product_name" placeholder="Product Name" required>
                            @endif
                        </div>
                        <div class="form-group">
                            <label for="add_product_price">Price</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="add_product_price" pattern="[0-9]+(\.[0-9]+)?$" value="{{$product->price}}" required>
                            @else
                            <input type="text" class="form-control" id="add_product_price" pattern="[0-9]+(\.[0-9]+)?$" placeholder="Product Price" required>
                            @endif
                        </div>
                        <div class="form-group">
                            <label for="product_quantity">Quantity</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="product_quantity" pattern="[0-9]+" value="{{$product->quantity_available}}" required>
                            @else
                            <input type="text" class="form-control" id="product_quantity" pattern="[1-9][0-9]*" placeholder="Poduct Quantity" required>
                            @endif
                        </div>
                        <div class="form-group">
                            <label for="product_brand">Brand</label>
                            @if($product != null)
                            <input type="text" class="form-control" id="product_brand" value="{{$product->brand}}" required>
                            @else
                            <input type="text" class="form-control" id="product_brand" placeholder="Product Brand" required>
                            @endif
                        </div>
                    </fieldset>
                </form>
            </div>
        </section>
    </div>
    <div class="container">
        <section class="mt-5">
            <h2>Photos</h2>
            <div class="cards photo-cards row">
                @each('partials.add_photo',$photos,'photo')
                <div class="mt-4 col-md-6 col-lg-3" >
                    <div class="box d-flex flex-column last-card" id="addPhoto">
                        Add Photo
                    </div>
                </div>
            </div>
        </section>
    </div>
    <div class="container">
        <section class="mt-5">
            <h2>Tech Specs</h2>
            <div class="alert alert-danger" id="specs-error" style="display:none; margin-top: 2em;"></div>
            <div class="cards specs-cards row">
                @include('partials.add_spec', ['category'=>$category, 'properties'=>$category->properties,'product'=>$product])     
            </div>
        </section>
        <div id="save_product_button" class="d-flex flex-column">
            <input type="submit" form="requiredForm" class="black-button mt-2 ml-auto saveProduct-btn" 
            @if($product != null)
                value="Edit Product" 
                id="editProductButton"
            @else 
                value="Add Product"
                id="addProductButton"
            @endif >
        </div>
    </div>
</main>

@endsection