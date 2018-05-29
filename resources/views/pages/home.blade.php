@extends('layouts.app')

@section('title', 'Sweven')

@section('content')

<script src={{ asset('js/product.js') }} defer></script>

<div id="carouselHomepage" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carouselHomepage" data-slide-to="0" class="active"></li>
        <li data-target="#carouselHomepage" data-slide-to="1"></li>
        <li data-target="#carouselHomepage" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img class="d-block w-100" src="{{ asset('../assets/slider1.jpg') }}" alt="Summer Offers: up to 30% off">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="{{ asset('../assets/slider2.jpg') }}" alt="iPhone X: shop now">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="{{ asset('../assets/slider3.jpg') }}" alt="Surface Pro: shop now">
        </div>
    </div>
    <a class="carousel-control-prev" href="#carouselHomepage" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselHomepage" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<main>
    <div class="mt-5 container">
        <h2>Highlights</h2>
        <div class="row">
        @foreach($products as $product)
            <div class="mt-4 col-md-6 col-lg-3">
                <div class="box d-flex flex-column align-items-center">
                    <a href="{{ route('product', ['product_id'=> $product->id]) }}"><img src="{{ $product->photos->get(0)->path }}" alt="{{ $product->name }}" class="img-fluid" style="cursor:pointer;"></a>
                    <a href="{{ route('product', ['product_id'=> $product->id]) }}"><h6 style="cursor:pointer;">{{ $product->name }}</h6></a>
                    <span>{{ $product->price }} €</span>
                    <input type="button" value="Add To Cart" onclick="return addToCart(null, {{$product->id}})">
                </div>
            </div>
        @endforeach
        </div>
    </div>
</main>
@endsection
