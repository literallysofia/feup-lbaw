@extends('layouts.app')

@section('title', 'Sweven | ' . $product->name)

@section('content')

@include('partials.breadcrumbs', $data = array($product->category->name => route('category_products', $product->category->id), $product->name => ''))

<script type="text/javascript" src={{ asset('js/product.js') }} defer></script>
<script type="text/javascript" src={{ asset('js/review.js') }} defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/2.3.0/mustache.min.js"></script>

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
                        <h1 class="text-center">{{ $product->name }}</h1>
                        <div class="stars mt-2">
                            <input type="hidden" value="{{$product->score}}">
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
                        <input type="button" class="black-button col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-12 mt-4" value="Add to Cart" onclick="return addToCart(null, {{$product->id}})"></input>
                        <input type="button" class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-xs-12 mt-4" value="Add to Wishlist" onclick="return addToWishlist({{$product->id}})"></input>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="mt-5">
        <div class="container">
            <h2>Tech Specs</h2>
            <div class="section-container">
                <?php $properties = $product->category_properties ?>
                @for($i=0; $i<count($properties); $i++)
                    <div class="container product-spec">
                        <div class="row">
                            <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                <p class="product-property">{{$properties[$i]->property->name}}</p>
                                <hr class="specs-title-line">
                            </div>
                            <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-xs-12">
                                <?php $property_values = $properties[$i]->values_lists->where('product_id', $product->id)->get(0)->values; ?>
                                @foreach($property_values as $value)
                                    <p class="row-specs">{{$value->name}}</p>
                                @endforeach 
                            </div>
                        </div>
                    </div>
                    @if($i < (count($properties)-1))
                        <hr class="mt-1 specs-break-line">
                    @endif
                @endfor
            </div>
        </div>
    </section>

    <section class="mt-5">
        <div class="container">
            <div class="d-flex">
                <div class="d-flex flex-row">
                    <h2>Reviews</h2>
                    <h2 id="reviews_counter">/{{count($product->reviews)}}</h2>
                </div>
                <div class="ml-auto">
                    <nav class="pagination-links" aria-label="Page navigation">
                        @include('partials.products.pagination_review')
                    </nav>
                </div>
            </div>

            <div class="section-container">
                <div id="reviews" class="container">
                    @if(count($product->reviews) == 0)
                        <p style="text-align: center">There's not any review yet</p>
                    @endif
                    @for($i=0; $i<count($reviews); $i++)
                        <div class="review-item row col-12 ml-0">
                            <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-xs-12">
                                <div class="d-flex flex-column align-items-start">
                                    <div class="stars">
                                    <input type="hidden" value="{{$reviews[$i]->score}}"> 
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
                                        <strong>{{$reviews[$i]->user->name}}</strong>
                                    </p>
                                    <p>{{date('d F Y', strtotime($reviews[$i]->date))}}</p>

                                </div>
                            </div>
                            <div class="col-xl-10 col-lg-10 col-md-9 col-sm-8 col-xs-12">
                                <div class="d-flex flex-column align-items-start review_comment">
                                    <h1>{{$reviews[$i]->title}}</h1>
                                    <p>{{$reviews[$i]->content}}</p>
                                </div>
                            </div>
                            @if(Auth::id() == $reviews[$i]->user_id)
                                <div class="d-flex flex-row align-items-end col-12">
                                    <a class="ml-auto mr-3" onclick="editReview({{$product->id}},{{$reviews[$i]->id}}, '{{$reviews[$i]->title}}', '{{$reviews[$i]->content}}', {{$reviews[$i]->score}})" data-toggle="modal" data-target="#giveOpinionModal">
                                        <i class="fas fa-lg fa-pencil-alt "></i>
                                    </a>
                                    <a onclick="deleteReview(this, {{$reviews[$i]->id}}, {{$product->id}})">
                                        <i class="fas fa-lg fa-trash-alt"></i>
                                    </a>
                                </div>
                            @endif
                        </div>
                        @if($i < (count($reviews)-1))
                            <hr class="my-4">
                        @endif
                    @endfor
                    @can('review', $product)
                        <hr class="my-4">
                        <div id="opinion_product" class="d-flex flex-row justify-content-end col-12">
                            <input type="button" class="col-lg-3 col-xl-3 col-md-5 col-sm-6 col-xs-12" value="Give your Opinion" data-toggle="modal"
                                data-target="#giveOpinionModal"></input>
                        </div>
                    @endcan
                </div>
            </div>
            <div class="d-flex justify-content-end mt-3">
                <nav class="pagination-links" aria-label="Page navigation">
                    @include('partials.products.pagination_review')
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
                    <form id="give_opinion_form" onsubmit="return newOpinion({{ $product->id }})">
                        <fieldset>
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
                                <input id="opinion_rate" type="hidden" value="" required></input>
                            </div>
                            <div class="form-group">
                                <label for="review_title">Title</label>
                                <input type="text" class="form-control" id="review_title" placeholder="Your title" required>
                            </div>
                            <div class="form-group">
                                <label for="review_text">Review</label>
                                <textarea form="give_opinion_form" rows="4" cols="10" id="review_text" placeholder="Your review" required></textarea>
                            </div>
                        </fieldset>
                        <div class="modal-footer">
                            <input type="button" data-dismiss="modal" value="Close"></input>
                            <input type="submit" class="black-button" value="Save"></input>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
<script id="template" type="x-tmpl-mustache">
    @include('partials.templates.review')
</script> 
@endsection
