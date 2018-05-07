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
            <select class="selectpicker">
                <option>Sort by</option>
                <option>Price low to high</option>
                <option>Price high to low </option>
                <option>Highest rating</option>
            </select>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    {{ $products->links() }}
                </ul>
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
                    <div class="range-slider">
                        <input class="range-slider__range" type="range" value="0" min="0" max="{{ $max_price }}">
                        <span class="range-slider__value"></span>
                    </div>
                </div>
            </div>
            <div class="col-md-8 col-lg-9">
                <div class="row">
                    @each('partials.product', $products,'product')
                </div>
            </div>
        </div>
        <nav class="mt-4 d-flex justify-content-end" aria-label="Page navigation">
            <ul class="pagination">
                {{ $products->links() }}
            </ul>
        </nav>
    </div>
</main>
@endsection