@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array($category->name => ''))

<script type="text/javascript" src={{ asset('js/price_slider.js') }} defer></script>

<main>
    <div class="container">
        <div class="products d-flex justify-content-between align-items-center flex-wrap">
            <h1>{{ $category->name }}</h1>
            <span>{{ $products->total() }} Products</span>
            <div class="dropdown show">
                <a class="dropdown-toggle" href="https://example.com" id="dropdownSort" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Sort by</a>
                <div class="dropdown-menu" aria-labelledby="dropdownSort">
                    <a class="dropdown-item" href="{{ route('category_products', ['category_id' => $category->id, 'sort' => '1']) }}">Price low to high</a>
                    <a class="dropdown-item" href="{{ route('category_products', ['category_id' => $category->id, 'sort' => '2']) }}">Price high to low</a>
                    <a class="dropdown-item" href="{{ route('category_products', ['category_id' => $category->id, 'sort' => '3']) }}">Highest rating</a>
                </div>
            </div>
            <nav class="pagination-links" aria-label="Page navigation">
            @include('partials.pagination')
            </nav>
        </div>
        <hr>
        <div class="row">
            <div class="mt-4 col-md-4 col-lg-3">
                <div class="filters d-flex flex-column">
                    <h5>Filters</h5>
                    @if (count($brands) >= 1)
                        <h6>Brand</h6>
                        @each('partials.filter', $brands,'brand')
                    @endif
                    <h6>Max Price</h6>
                    <form class="range-slider" action="{{ route('category_products', ['category_id' => $category->id, 'max_price' => '800']) }}" method="get">
                        <input class="range-slider__range" name="max_price" type="range" value="0" min="0" max="{{ $max_price }}">
                        <span class="range-slider__value"></span>
                    </form>
                </div>
            </div>
            <div class="col-md-8 col-lg-9">
                <div id="product-listing" class="row">
                    @include('partials.product')
                </div>
            </div>
        </div>
        <nav class="mt-4 d-flex justify-content-end pagination-links" aria-label="Page navigation">
        @include('partials.pagination')
        </nav>
    </div>
</main>
@endsection
