@extends('layouts.app')

@section('title','Contact')

@section('content')

@include('partials.breadcrumbs', $data = array('Contact' => ''))

<main>
<div class="container">
            <h1>Contact Us</h1>

            <div class="section-container contact">

                <p>We're happy to answer any questions you have or provide you an estimate. Just send us a message in the form
                    below with any questions you may have.
                </p>

                <div class="row">

                    <div class="col-lg-9 col-md-9 col-sm-12">

                        <form action="" class="contact-form">
                            <div class="form-group">
                                <label for="name">YOUR NAME (required)</label>
                                <input type="text" class="form-control" id="name" placeholder="Full Name">
                            </div>
                            <div class="form-group">
                                <label for="email">YOUR EMAIL (required)</label>
                                <input type="email" class="form-control" id="email" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <label for="subject">SUBJECT</label>
                                <input type="text" class="form-control" id="subject" placeholder="Subject">
                            </div>
                            <div class="form-group">
                                <label for="message">YOUR MESSAGE</label>
                                <textarea class="form-control" id="message" rows="5" placeholder="Explain your problems or concerns."></textarea>
                            </div>
                            <input type="button" class="black-button" value="Send"></input>
                        </form>
                    </div>

                    <div class="col-lg-3 col-md-3 col-sm-12 d-flex flex-column contact-info">
                        <div>
                            <p class="font-weight-bold">EMAIL</p>
                            <p>info@sweven.com</p>
                            <hr>
                        </div>
                        <div>
                            <p class="font-weight-bold">PHONE</p>
                            <p>+315 222 222 222</p>
                            <hr>
                        </div>
                    </div>
                </div>
</div>



</main>