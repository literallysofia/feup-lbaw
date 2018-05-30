@extends('layouts.app') 

@section('title','Sweven | Profile')

@section('content') 

@include('partials.breadcrumbs', $data = array('Client Area' => ''))

<script src={{ asset('js/addressRequest.js') }} defer></script>
<script src={{ asset('js/profileRequest.js') }} defer></script>
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
        <div class="col-lg-auto col-md-auto col-sm-12 text-sm-left" data-toggle="modal" data-target="#online_help_modal" style="cursor:pointer;">
          <i class="fas fa-question-circle"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="online_help_modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">Online Help</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body section-container mt-0">
          <p>As a user, on this page, you can edit your personal details and manage your addresses.</p>
          <p>You can view all your purchases, those bellow <strong>On Hold</strong> are being processed or have just been shipped, once a package is delivered, you can find it under <strong>History</strong>.</p>
          <p>If you click on a particular purchase, you can see all its details.</p>
        </div>
      </div>
    </div>
  </div>

  <div class="container">

    <section class="mt-5">

      <div id="profile_title" class="jumptarget">
        <h2>Profile</h2>
      </div>

      <div class="section-container">
        <form id="profile_form">
        <fieldset>
            <div class="form-group">
              <label for="profile_name">Name</label>
              <input type="text" class="form-control" oninvalid="this.setCustomValidity('Please enter a valid name')" oninput="this.setCustomValidity('')"
                pattern="^[A-Z][a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$" id="profile_name" value="{{$user->name}}">
            </div>
            <div class="form-group">
              <label for="profile_username">Username</label>
              <input type="text" class="form-control" oninvalid="this.setCustomValidity('Username must have at least 6 characters')" oninput="this.setCustomValidity('')"
                pattern="^[a-zA-Z0-9]{6,20}$" id="profile_username" value={{$user->username}}>
            </div>
            <div class="form-group">
              <label for="profile_email">Email</label>
              <input type="email" class="form-control" id="profile_email" value={{$user->email}}>
            </div>
          </fieldset>
          <fieldset>
            <legend>Change Password <span>(optional)</span></legend>
            <div class="form-group">
              <input type="password" class="form-control" id="profile_oldpassword" placeholder="Old Password">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" oninvalid="this.setCustomValidity('Password must have one uppercase letter, one number and at least 8 characters')"
                oninput="this.setCustomValidity('')" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$" id="profile_newpassword"
                placeholder="New Password">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" id="password_confirmation" placeholder="Repeat New Password">
            </div>
            <div class="d-flex flex-column">
              <input id="btn-saveProfile" type="submit" value="Save">
            </div>
          </fieldset>
        </form>
      </div>

    </section>
  </div>


  <div class="container">
    <section class="mt-5">

      <div id="addresses_title" class="jumptarget">
        <h2>Addresses</h2>
      </div>

      <div class="cards row" id="addresses_cards">
        @each('partials.address', $addresses,'address')
        <div class="mt-4 col-md-6 col-lg-3">
          <div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#add_address_modal">
            Add Address
          </div>
        </div>
      </div>
    </section>
  </div>

  <div class="modal fade" id="add_address_modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">Add Address</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body section-container mt-0">
          <form id="add_address_form">
            <fieldset>
              <div class="form-group">
                <label for="address-name">Name</label>
                <input id="address-name" class="form-control" type="text" oninvalid="this.setCustomValidity('Address name can only be 30 chracters long')"
                oninput="this.setCustomValidity('')" pattern=".{1,30}" required>
              </div>
              <div class="form-group">
                <label for="address-street">Street</label>
                <input id="address-street" class="form-control" type="text" required>
              </div>
              <div class="form-group">
                <label for="address-postal">Postal Code</label>
                <input id="address-postal" class="form-control" type="text" oninvalid="this.setCustomValidity('Please enter a valid postal code (eg: NNNN-NNN)')"
                  oninput="this.setCustomValidity('')" pattern="[0-9]{4}-[0-9]{3}" required>
              </div>
              <div class="form-group">
                <label for="countries_selector">Country</label>
                <select id="countries_selector" class="form-control" onchange="filterCities(this)" required>
                  <option value="" disabled selected>Select country</option>
                  @foreach($countries as $country)
                  <option value="{{$country->id}}">{{$country->name}}</option>
                  @endforeach
                </select>
              </div>
              <div class="form-group">
                <label for="cities_selector">City</label>
                <select id="cities_selector" class="form-control" required>
                  <option value="" disabled selected>Select city</option>
                  @foreach($cities as $city)
                  <option value="{{$city->id}}" data-value="{{$city->country_id}}">{{$city->name}}</option>
                  @endforeach
                </select>
              </div>
            </fieldset>
            <div class="modal-footer">
              <input type="button" data-dismiss="modal" value="Close">
              <input type="submit" class="black-button" value="Save">
            </div>
          </form>
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
            @each('partials.purchase', $processing_purchases,'purchase')
            @each('partials.purchase', $shipped_purchases,'purchase')            
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
            @each('partials.purchase', $delivered_purchases,'purchase')
          </tbody>
        </table>
      </div>

    </section>
  </div>

</main>

@endsection