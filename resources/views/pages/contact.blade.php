@extends('layouts.app')

@section('title','Contact')

@section('content')

@include('partials.breadcrumbs', $data = array('Contact' => ''))

<main>
    <div class="container">
        <h1>Contact Us</h1>
        <div class="section-container contact">
            <p>We're happy to answer any questions you have or provide you an estimate. Just send us a message in the form below with any questions you may have.</p>
            <div class="row">
                <div class="col-lg-9 col-md-9 col-sm-12">
                    <form action="{{route('sendemail')}}" class="contact-form" method="post">
                        @if(Session::has('success'))
                            <div class="alert alert-success">{{Session::get('success')}}</div>
                        @elseif(Session::has('error'))
                            <div class="alert alert-danger">{{Session::get('error')}}</div>
                        @endif
                        
                        <input type="hidden" name="_token" value="{!! csrf_token() !!}">
                        <div class="form-group">
                            <label for="name">YOUR NAME (required)</label>
                            <input type="text" class="form-control" id="name"  pattern="^[A-Z][a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$" name="name" placeholder="Full Name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">YOUR EMAIL (required)</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                        </div>
                        <div class="form-group">
                            <label for="subject">SUBJECT</label>
                            <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject">
                        </div>
                        <div class="form-group">
                            <label for="message">YOUR MESSAGE</label>
                            <textarea class="form-control" id="message" name="message" rows="5" placeholder="Explain your problems or concerns."></textarea>
                        </div>

                        <input type="submit" class="black-button" value="Send">
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
    </div>
</main>

@endsection