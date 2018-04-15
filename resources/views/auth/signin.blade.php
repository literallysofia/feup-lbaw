@extends('layouts.app')

@section('content')
@include('partials.breadcrumbs', $data = array('Sign In' => ''))
<main>
<div class="container">
    <div class="section-container register">
        <div class="row">
            <div class="col-lg-7 col-md-6 col-sm-12 d-flex justify-content-center align-items-center">
                <figure>
                    <img src="{{ asset('../assets/logo.svg') }}" class="img-fluid rounded mx-auto d-block" alt="Sweven Logo">
                    <figcaption>The technology of your dreams.</figcaption>
                </figure>
            </div>
            <div class="col-lg-5 col-md-6 col-sm-12 d-flex align-items-center">
                <div class="register-form">
                    <h3>Sign In</h3>
                    <form method="POST" action="{{ route('signin') }}">
                        {{ csrf_field() }}
                        <div class="form-group">
                            <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" placeholder="Email" required>
                            @if ($errors->has('email'))
                                <span class="error">
                                    {{ $errors->first('email') }}
                                </span>
                            @endif
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" id="pass" name="password" placeholder="Password" required>
                            @if ($errors->has('password'))
                                <span class="error">
                                    {{ $errors->first('password') }}
                                </span>
                            @endif
                        </div>
                        <input type="submit" class="black-button" value="Sign In"></input>
                    </form>
                    <span class="float-right">New to Sweven?
                        <a href="{{ url('register') }}">Create an account.</a>
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
</main>
@endsection
