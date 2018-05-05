@extends('layouts.app')

@section('title','Wishlist')

@section('content')

@include('partials.breadcrumbs', $data = array('Cart' => ''))

<script type="text/javascript" src={{ asset('js/cart.js') }} defer></script>
<main>
        <div class="container">
            <h1>My Cart</h1>
            <div class="section-container">
                @foreach($products as $product)
                    <div class="cart-item row">
                        <div class="col-xl-2 col-lg-2 col-md-3 col-sm-12 col-xs-12 pb-lg-0 pb-md-0 pb-sm-3">
                            <div class="d-flex flex-column align-items-center cart_item_img">
                                <img src="{{$product->photos->get(0)->path}}" alt="Item 1" class="img-fluid">
                            </div>
                        </div>
                        <div class="col-xl-10 col-lg-10 col-md-9 col-sm-12 col-xs-12">
                            <div class="info-item d-flex flex-column">
                                <div>
                                    <h5>{{$product->name}}</h5>
                                </div>
                                <div class="d-flex flex-row cart-item-quantity">
                                    <p>Quantity:</p>
                                    <input value="1" disabled>
                                    <p>
                                        <i class="fas fa-minus"></i>
                                        <i class="fas fa-plus"></i>
                                    </p>
                                </div>
                                <div class="remove-item-cart mt-auto d-flex align-items-end">
                                    <a class="mr-auto mt-auto" href="#">Remove</a>
                                    <div class="info-item ">
                                        <p class="mb-auto">{{$product->price}} €</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
                @endforeach
                <div id="end_cart" class="col-12 d-flex justify-content-end align-items-center">
                    <p class="subtotal">Subtotal before delivery: </p>
                    <p>{{collect($products)->sum('price')}} €</p>
                </div>
                <div id="checkout_cart" class="d-flex flex-row justify-content-end">
                    <input type="button" class="black-button" value="Checkout" data-toggle="modal" data-target="#checkoutModal"></input>
                </div>
            </div>
        </div>

        <div class="modal fade" id="checkoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Checkout</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body section-container mt-0 d-flex flex-column">
                        <h6>Delivery Address</h6>
                        <select>
                            <option disabled selected value>Choose Address</option>
                            @foreach($addresses as $address)
                                <option value="{{$address->id}}">{{$address->name}} - {{$address->street}}, {{$address->postal_code}} {{$address->city->name}}, {{$address->city->country->name}} </option>
                            @endforeach
                        </select>
                        <h6>Subtotal before Delivery</h6>
                        <p>{{collect($products)->sum('price')}} €</p>
                        <h6>Delivery Type</h6>
                        <select>
                            <option disabled selected value>Choose Delivery Type</option>
                            @foreach($delivery_types as $delivery)
                                <option value="{{$delivery->id}}">{{$delivery->name}} (+{{$delivery->price}} €)</option>
                            @endforeach
                        </select>
                        <h6 class="ml-auto">Total</h6>
                        <p class="ml-auto">2179,98 €</p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" data-dismiss="modal" value="Close"></input>
                        <input type="button" class="black-button" value="Purchase"></input>
                    </div>
                </div>
            </div>
        </div>



    </main>
@endsection