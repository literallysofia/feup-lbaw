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
              <input type="text" class="form-control" id="profile_name" placeholder={{$user->name}}>
            </div>
            <div class="form-group">
              <label for="profile_username">Username</label>
              <input type="text" class="form-control" id="profile_username" placeholder={{$user->username}}>
            </div>
            <div class="form-group">
              <label for="profile_email">Email</label>
              <input type="text" class="form-control" id="profile_email" placeholder={{$user->email}}>
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

        <div class="cards row" id="addresses_cards">
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
                <input type="text" class="form-control" pattern="[0-9]{4}-[0-9]{3}" placeholder="Your postal code">
              </div>
              <div class="form-group">
                <label for="review_title">City</label>
                <input type="text" class="form-control" placeholder="Your city">
              </div>
              <div class="form-group">
                <label for="review_title">Country</label>
                <input type="text" class="form-control" placeholder="Your country">
              </div>

            </form>
          </div>
          <div class="modal-footer">
            <input type="button" data-dismiss="modal" value="Close"></input>
            <input type="button" class="black-button" id="btn-addAddress" value="Save"></input>
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
              @each('partials.purchase', $purchases->where('status','=','Shipped'),'purchase')
              @each('partials.purchase', $purchases->where('status', '=', 'Processing'),'purchase')
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
            @each('partials.purchase', $purchases->where('status', '=', 'Delivered'),'purchase')
            </tbody>
          </table>
        </div>

      </section>
    </div>

  </main>

@endsection