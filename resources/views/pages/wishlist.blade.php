@extends('layouts.app')

@section('title','Wishlist')

@section('content')

@include('partials.breadcrumbs', $data = array('Wishlist' => ''))

<script type="text/javascript" src={{ asset('js/wishlist.js') }} defer></script>
<main>
    <div class="container">
        <h1>My Wishlist</h1>
        <div class="section-container">
            @foreach($products as $product)
                <form class="cart-item row" onsubmit="return addToCart(this, {{$product->id}})">
                    <div class="col-xl-2 col-lg-2 col-md-3 col-sm col-xs">
                        <div class="d-flex flex-column align-items-center cart_item_img">
                            <img src="{{$product->photos->get(0)->path}}" alt="Item 1" class="img-fluid">
                        </div>
                    </div>
                    <div class="col-xl-10 col-lg-10 col-md-9 col-sm-auto col-xs-auto">
                        <div class="info-item d-flex flex-column">
                            <div>
                                <h5>{{$product->name}}</h5>
                                <p class="mt-auto ml-auto">{{$product->price}} €</p>
                            </div>
                            <div class="d-flex align-items-end mt-auto">
                                <div class="remove-item-cart">
                                    <button onclick="return deleteProduct(this, {{$product->id}})">Remove</button>
                                </div>
                                <input type="submit" class="ml-auto black-button" value="Add to Cart"></input>
                            </div>
                        </div>
                    </div>
                </form>
                <hr class="my-4">
            @endforeach
        </div>
    </div>
</main>
@endsection