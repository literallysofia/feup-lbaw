@extends('layouts.app')

@section('content')
@include('partials.breadcrumbs', $data = array('Client Area' => ''))
<script src="../js/profile_purchases.js"></script>

<main>
    <div class="container">
      <div class="container scroll_nav">
        <div class="row">
          <h1 class="col-lg col-md col-sm-12">
            Client Area
          </h1>
          <a href="#profile_title" class="col-lg-auto col-md-auto col-sm-12 text-sm-left">
            Profile
          </a>
          <a href="#addresses_title" class="col-lg-auto col-md-auto col-sm-12 text-sm-left">
            Addresses
          </a>
          <a href="#onhold_title" class="col-lg-auto col-md-auto col-sm-12 text-sm-left">
            On Hold
          </a>
          <a href="#history_title" class="col-lg-auto col-md-auto col-sm-12 text-sm-left">
            History
          </a>
        </div>
      </div>
    </div>


    <div class="container">

      <section class="mt-5">

        <div id="profile_title" class="jumptarget">
          <h2>Profile</h2>
        </div>

        <div class="section-container">
          <form>
            <div class="form-group">
              <label for="profile_name">Name</label>
              <input type="text" class="form-control" id="profile_name" placeholder="John Doe">
            </div>
            <div class="form-group">
              <label for="profile_username">Username</label>
              <input type="text" class="form-control" id="profile_username" placeholder="johndoe">
            </div>
            <div class="form-group">
              <label for="profile_email">Email</label>
              <input type="text" class="form-control" id="profile_email" placeholder="johndoe@email.com">
            </div>
            <label>Optional</label>
            <div class="form-group">
              <input type="password" class="form-control" id="profile_newpassword" placeholder="New Password">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" id="profile_newpassword_confirmation" placeholder="New Password Confirmation">
            </div>
          </form>
          <div class="d-flex flex-column">
            <input type="button" value="Save"></input>
            <input type="button" class="black-button mt-3" value="Delete Account"></input>
          </div>
        </div>

      </section>
    </div>


    <div class="container">
      <section class="mt-5">

        <div id="addresses_title" class="jumptarget">
          <h2>Addresses</h2>
        </div>

        <div class="cards row">
          @each('partials.address', $addresses,'address')
          <div class="mt-4 col-md-6 col-lg-3">
            <div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#addAddressModal">
              Add Address
            </div>
          </div>
        </div>
      </section>
    </div>

    <div class="modal fade" id="addAddressModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">Add Address</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body section-container mt-0">
            <form>
              <div class="form-group">
                <label for="review_title">Name</label>
                <input type="text" class="form-control" placeholder="Address Name">
              </div>
              <div class="form-group">
                <label for="review_title">Street</label>
                <input type="text" class="form-control" placeholder="Your street">
              </div>
              <div class="form-group">
                <label for="review_title">Postal Code</label>
                <input type="text" class="form-control" placeholder="Your postal code">
              </div>
              <div class="form-group">
                <label for="review_title">Country</label>
                <select class="form-control" onchange="filterCities(this)">
                  <option value="" disabled selected>Select your country</option>
                  @foreach($countries as $country)
                  <option value="{{$country->id}}" placeholder="Your country">{{$country->name}}</option>
                  @endforeach
                </select>
              </div>
              <div class="form-group">
                <label for="review_title">City</label>
                <select class="form-control" id="cities_selector">
                  <option value="" disabled selected>Select your city</option>
                  @foreach($cities as $city)
                  <option value="{{$city->id}}" data-value="{{$city->country_id}}" placeholder="Your city">{{$city->name}}</option>
                  @endforeach
                </select>
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

    <div class="container">
      <section class="mt-5">


        <div id="onhold_title" class="jumptarget">
          <h2>On Hold</h2>
        </div>

        <div class="section-container">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Date</th>
                <th scope="col">Status</th>
                <th scope="col">Total</th>
              </tr>
            </thead>
            <tbody>
              @each('partials.purchase', $purchases,'purchase')
             
              <!--<tr data-toggle="collapse" data-target="#purchase-1" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>18/02/17</td>
                <td>Processing</td>
                <td>2000€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-1" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-2" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>15/02/17</td>
                <td>Processing</td>
                <td>750€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-2" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-3" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Shipped</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-3" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-4" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Shipped</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-4" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-5" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Shipped</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-5" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-6" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Shipped</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-6" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>-->
            </tbody>
          </table>
        </div>

      </section>
    </div>

    <div class="container">
      <section class="mt-5">


        <div id="history_title" class="jumptarget">
          <h2>History</h2>
        </div>

        <div class="section-container">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">Date</th>
                <th scope="col">Status</th>
                <th scope="col">Total</th>
              </tr>
            </thead>
            <tbody>
              <tr data-toggle="collapse" data-target="#purchase-7" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-7" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-8" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-8" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-9" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-9" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-10" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-10" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-11" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-11" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-12" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-12" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
              <tr data-toggle="collapse" data-target="#purchase-13" class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>10/02/17</td>
                <td>Delivered</td>
                <td>1500€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id="purchase-13" class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

      </section>
    </div>

  </main>

@endsection