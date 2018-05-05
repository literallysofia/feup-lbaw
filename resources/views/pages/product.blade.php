@extends('layouts.app')

@section('title','Wishlist')

@section('content')

<?php $category_name = $product->category->name; ?>

@include('partials.breadcrumbs', $data = array($category_name => route('category_products', $category_name), $product->name => ''))

<main>
    <section class="mt-4">
        <div class="container">
            <div class="section-container">
                <div class="row">
                    <div id="productCarouselIndicators" class="col-md-6 col-sm-12 carousel slide align-self-center" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="../assets/laptop.jpg" alt="Item 1" class="img-fluid">
                            </div>
                            @for($i=0; $i<count($product->photos); $i++)
                                <div class="carousel-item">
                                    <img src="{{$product->photos[$i]->path}}" alt="Item 1" class="img-fluid">
                                </div>
                            @endfor
                        </div>
                        <a class="carousel-control-prev" href="#productCarouselIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#productCarouselIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                    <div class="col-md-6 col-sm-12 d-flex flex-column align-items-center align-self-center">
                        <h1 class="text-center">{{$product->name}}</h1>
                        <div class="stars mt-2">
                            <div class="stars-outer">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <div class="stars-inner">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                            </div>
                        </div>
                        <p class="mt-1" id="product_price">{{$product->price}} €</p>
                        <input type="button" class="black-button col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-12 mt-4" value="Add to Cart"></input>
                        <input type="button" class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-12 mt-4" value="Add to Wishlist"></input>
                    </div>
                </div>
            </div>

        </div>
    </section>


    <section class="mt-5">
        <div class="container">

            <h2>Tech Specs</h2>

            <div class="section-container">
                <div class="container product-spec">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <p class="product-property">Storage</p>
                            <hr class="specs-title-line">
                        </div>
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <p class="row-specs">256GB</p>
                        </div>
                    </div>
                </div>
                <hr class="mt-1 specs-break-line">
                <div class="container product-spec">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <p class="product-property">Chip</p>
                            <hr class="specs-title-line">
                        </div>
                        <hr class="specs-title-line">
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <p class="row-specs">A11 Bionic chip with 64-bit architecture</p>
                        </div>
                    </div>
                </div>
                <hr class="mt-1 specs-break-line">
                <div class="container product-spec">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <p class="product-property">Location</p>
                            <hr class="specs-title-line">
                        </div>
                        <hr class="specs-title-line">
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <p class="row-specs">Assisted GPS, GLONASS, Galileo, and QZSS</p>
                            <p class="row-specs">Digital compass</p>
                            <p class="row-specs">Wi-Fi</p>
                            <p class="row-specs">Cellular</p>
                            <p class="row-specs">iBeacon microlocation</p>
                        </div>
                    </div>
                </div>
                <hr class="mt-1 specs-break-line">
                <div class="container product-spec">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <p class="product-property">Power and Battery</p>
                            <hr class="specs-title-line">
                        </div>
                        <hr class="mt-1 specs-title-line">
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <p class="row-specs">Up to 21h (wireless)</p>
                            <p class="row-specs">Up to 50% charge 30 minutes</p>
                        </div>
                    </div>
                </div>
                <hr class="mt-1 specs-break-line">
                <div class="container product-spec">
                    <div class="row">
                        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            <p class="product-property">Sensors</p>
                            <hr class="specs-title-line">
                        </div>
                        <hr class="specs-title-line">
                        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                            <p class="row-specs">Face ID</p>
                            <p class="row-specs">Barometer</p>
                            <p class="row-specs">Three-axis gyro</p>
                            <p class="row-specs">Accelerometer</p>
                            <p class="row-specs">Proximity sensor</p>
                            <p class="row-specs">Ambient light sensor</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <section class="mt-5">
        <div class="container">
            <div class="d-flex">
                <div class="d-flex flex-row">
                    <h2>Reviews</h2>
                    <?php $reviews = $product->reviews ?>
                    <h2 id="reviews_counter">/{{count($reviews)}}</h2>
                </div>
                <div class="ml-auto">
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
            </div>

            <div class="section-container">
                <div class="container">
                    <div class="review-item row col-12 ml-0">
                        <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
                            <div class="d-flex flex-column align-items-start">
                                <div class="stars">
                                    <div class="stars-outer">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <div class="stars-inner">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="review-info">
                                <p>By
                                    <strong>John Doe</strong>
                                </p>
                                <p>26 Dec 2017</p>

                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
                            <div class="d-flex flex-column align-items-start review_comment">
                                <h1>Title</h1>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel ultricies lacus.
                                    Praesent fermentum vehicula augue a convallis. Nulla vel cursus augue. Integer ut
                                    sem sapien. Duis fermentum facilisis nisi, eu finibus urna viverra ac. Proin non
                                    sapien vitae lacus finibus porta eget nec justo. Sed est ante, interdum eget nunc
                                    sit amet, malesuada ultricies purus. In molestie nunc ut neque finibus, nec blandit
                                    tellus tincidunt. Maecenas iaculis ipsum at nisi maximus lobortis. Fusce rutrum mi
                                    bibendum odio hendrerit porttitor. Morbi semper felis hendrerit neque varius malesuada.
                                    Maecenas rutrum, mauris vel sagittis suscipit, turpis odio malesuada leo, non cursus
                                    urna arcu vitae felis.</p>
                            </div>
                        </div>
                        <div class="d-flex flex-row align-items-end col-12">
                            <a class="ml-auto mr-3" data-toggle="modal" data-target="#giveOpinionModal">
                                <i class="fas fa-lg fa-pencil-alt "></i>
                            </a>
                            <a>
                                <i class="fas fa-lg fa-trash-alt"></i>
                            </a>
                        </div>

                    </div>
                    <hr class="my-4">
                    <div class="review-item row col-12  ml-0">
                        <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
                            <div class="d-flex flex-column align-items-start">
                                <div class="stars">
                                    <div class="stars-outer">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <div class="stars-inner">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="review-info">
                                <p>By
                                    <strong>John Doe</strong>
                                </p>
                                <p>26 Dec 2017</p>
                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
                            <div class="d-flex flex-column align-items-start review_comment">
                                <h1>Title</h1>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel ultricies lacus.
                                    Praesent fermentum vehicula augue a convallis. Nulla vel cursus augue. Integer ut
                                    sem sapien. Duis fermentum facilisis nisi, eu finibus urna viverra ac. Proin non
                                    sapien vitae lacus finibus porta eget nec justo. Sed est ante, interdum eget nunc
                                    sit amet, malesuada ultricies purus. In molestie nunc ut neque finibus, nec blandit
                                    tellus tincidunt. Maecenas iaculis ipsum at nisi maximus lobortis. Fusce rutrum mi
                                    bibendum odio hendrerit porttitor. Morbi semper felis hendrerit neque varius malesuada.
                                    Maecenas rutrum, mauris vel sagittis suscipit, turpis odio malesuada leo, non cursus
                                    urna arcu vitae felis.</p>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
                    <div class="review-item row col-12 ml-0">
                        <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
                            <div class="d-flex flex-column align-items-start">
                                <div class="stars">
                                    <div class="stars-outer">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <div class="stars-inner">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="review-info">
                                <p>By
                                    <strong>John Doe</strong>
                                </p>
                                <p>26 Dec 2017</p>
                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
                            <div class="d-flex flex-column align-items-start review_comment">
                                <h1>Title</h1>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel ultricies lacus.
                                    Praesent fermentum vehicula augue a convallis. Nulla vel cursus augue. Integer ut
                                    sem sapien. Duis fermentum facilisis nisi, eu finibus urna viverra ac. Proin non
                                    sapien vitae lacus finibus porta eget nec justo. Sed est ante, interdum eget nunc
                                    sit amet, malesuada ultricies purus. In molestie nunc ut neque finibus, nec blandit
                                    tellus tincidunt. Maecenas iaculis ipsum at nisi maximus lobortis. Fusce rutrum mi
                                    bibendum odio hendrerit porttitor. Morbi semper felis hendrerit neque varius malesuada.
                                    Maecenas rutrum, mauris vel sagittis suscipit, turpis odio malesuada leo, non cursus
                                    urna arcu vitae felis.</p>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
                    <div class="review-item row col-12 ml-0">
                        <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
                            <div class="d-flex flex-column align-items-start">
                                <div class="stars">
                                    <div class="stars-outer">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <div class="stars-inner">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="review-info">
                                <p>By
                                    <strong>Peter Doe</strong>
                                </p>
                                <p>26 Dec 2017</p>
                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
                            <div class="d-flex flex-column align-items-start review_comment">
                                <h1>Title</h1>
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel ultricies lacus.
                                    Praesent fermentum vehicula augue a convallis. Nulla vel cursus augue. Integer ut
                                    sem sapien. Duis fermentum facilisis nisi, eu finibus urna viverra ac. Proin non
                                    sapien vitae lacus finibus porta eget nec justo. Sed est ante, interdum eget nunc
                                    sit amet, malesuada ultricies purus. In molestie nunc ut neque finibus, nec blandit
                                    tellus tincidunt.</p>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
                    <div id="opinion_product" class="d-flex flex-row justify-content-end col-12">
                        <input type="button" class="col-lg-3 col-xl-3 col-md-5 col-sm-6 col-xs-12" value="Give your Opinion" data-toggle="modal"
                            data-target="#giveOpinionModal"></input>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-end mt-3">
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
        </div>
    </section>

    <div class="modal fade" id="giveOpinionModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Your opinion</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body section-container" id="review_body">
                    <form>
                        <div class="form-group">
                            <label for="rate_review">Global rate:</label>
                            <div class="d-flex justify-content-center">
                                <div id="review_stars">
                                    <div class="stars-outer">
                                        <i class="fas fa-star fa-lg"></i>
                                        <i class="fas fa-star fa-lg"></i>
                                        <i class="fas fa-star fa-lg"></i>
                                        <i class="fas fa-star fa-lg"></i>
                                        <i class="fas fa-star fa-lg"></i>
                                        <div class="stars-inner">
                                            <i class="fas fa-star fa-lg" data-alt="5" title="Excellent"></i>
                                            <i class="fas fa-star fa-lg" data-alt="4" title="Good"></i>
                                            <i class="fas fa-star fa-lg" data-alt="3" title="Average"></i>
                                            <i class="fas fa-star fa-lg" data-alt="2" title="Poor"></i>
                                            <i class="fas fa-star fa-lg" data-alt="1" title="Terrible"></i>
                                        </div>
                                    </div>
                                    <p id="rate_text">rate</p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="review_title">Title</label>
                            <input type="text" class="form-control" id="review_title" placeholder="Your title">
                        </div>
                        <div class="form-group">
                            <label for="review_text">Review</label>
                            <textarea rows="4" cols="10" id="review_text" placeholder="Your review"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="button" data-dismiss="modal" value="Close"></input>
                    <input type="button" class="black-button" value="Save"></input>
                </div>
            </div>
        </div>
    </div>
</main>
@endsection
