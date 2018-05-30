@extends('layouts.app')

@section('title', 'Sweven | Search')

@section('content')

@include('partials.breadcrumbs', $data = array($keyword => ''))

<main>
    <div class="container">
    <div class="products d-flex justify-content-between align-items-center flex-wrap">
            <h1>{{ $keyword }}</h1>
            <span>{{ $products->total() }} Products</span>
            <nav class="pagination-links" aria-label="Page navigation">
                @include('partials.products.pagination')
            </nav>
        </div>
        <hr>
        @if($products->total() == 0)
            <span>Sorry, no products found.</span>
        @else
        <div class="row">
        @foreach($products as $product)
            <div class="mt-4 col-md-6 col-lg-3">
                <div class="box d-flex flex-column align-items-center">
                    <a href="{{route('product', ['product_id'=> $product->id])}}"><img src="{{ $product->photos->get(0)->path }}" alt="Item 1" class="img-fluid" style="cursor:pointer;"></a>
                    <a href="{{route('product', ['product_id'=> $product->id])}}"><h6 style="cursor:pointer;">{{$product->name}}</h6></a>
                    <span>{{$product->price}} €</span>
                    <input type="button" value="Add To Cart">
                </div>
            </div>
        @endforeach
        </div>
        @endif
        <nav class="mt-4 d-flex justify-content-end pagination-links" aria-label="Page navigation">
            @include('partials.products.pagination')
        </nav>
    </div>
</main>
@endsection
