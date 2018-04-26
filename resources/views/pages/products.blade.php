@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array($category_name => ''))
<main>
    <div class="container">
        <div class="products d-flex justify-content-between align-items-center flex-wrap">
            <h1>{{$category_name}}</h1>
            <span>200 Products</span>
            <select class="selectpicker">
                <option>Sort by</option>
                <option>Price low to high</option>
                <option>Price high to low </option>
                <option>Highest rating</option>
            </select>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
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
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                    <div class="mt-4 col-md-12 col-lg-4">
                        <div class="box d-flex flex-column align-items-center">
                            <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                            <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                            <span>1 359,99 €</span>
                            <input type="button" value="Add To Cart">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <nav class="mt-4 d-flex justify-content-end" aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only">Previous</span>
                    </a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">1</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">2</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#">3</a>
                </li>
                <li class="page-item">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        <span class="sr-only">Next</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</main>
@endsection