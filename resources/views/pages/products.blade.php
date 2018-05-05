@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array($category->name => ''))
<main>
    <div class="container">
        <div class="products d-flex justify-content-between align-items-center flex-wrap">
            <h1>{{$category->name}}</h1>
            <span><?php echo $products->total() ?> Products</span>
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
                    <h6>Brand</h6>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>Apple</p>
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>Samsung</p>
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>Google</p>
                        </label>
                    </div>
                    <h6>Storage</h6>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>256 GB</p>
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>128 GB</p>
                        </label>
                    </div>
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input">
                            <p>64 GB</p>
                        </label>
                    </div>
                    <h6>Max Price</h6>
                    <div class="range-slider">
                        <input class="range-slider__range" type="range" value="500" min="0" max="2000">
                        <span class="range-slider__value">0</span>
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