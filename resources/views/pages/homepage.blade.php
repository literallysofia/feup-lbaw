@extends('layouts.app')

@section('content')
<script type="text/javascript">
function openProduct(name) {
    var naame = name;
    let string = JSON.parse("{{ json_encode(route('product', ['product_name'=>"+name+"])) }}");
    window.location.href=string;
}
</script>
<div id="carouselHomepage" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carouselHomepage" data-slide-to="0" class="active"></li>
        <li data-target="#carouselHomepage" data-slide-to="1"></li>
        <li data-target="#carouselHomepage" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img class="d-block w-100" src="{{ asset('../assets/slider1.jpg') }}" alt="First slide">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="{{ asset('../assets/slider2.jpg') }}" alt="Second slide">
        </div>
        <div class="carousel-item">
            <img class="d-block w-100" src="{{ asset('../assets/slider3.jpg') }}" alt="Third slide">
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
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <a href="{{route('product', ['product_id'=> 1])}}"><img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" style="cursor:pointer;"></a>
                <a href="{{route('product', ['product_id'=> 1])}}"><h6 style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6></a>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver - Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
    </div>
    <div class="row">
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
        <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column align-items-center">
                <img src="../assets/phone.jpg" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;">
                <h6 onclick="window.location='product.html'" style="cursor:pointer;">Apple iPhone X - 256GB - Silver</h6>
                <span>1 359,99 €</span>
                <input type="button" value="Add To Cart">
            </div>
        </div>
    </div>
</div>
</main>
@endsection