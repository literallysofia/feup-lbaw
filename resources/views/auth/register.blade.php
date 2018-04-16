@extends('layouts.app')

@section('content')
@include('partials.breadcrumbs', $data = array('Register' => ''))
<main>
<div class="container">
    <div class="section-container register">
    <div class="row">
        <div class="col-lg-7 col-md-6 col-sm-12 d-flex justify-content-center align-items-center">
            <figure class="login-logo">
                <img src="../assets/logo.svg" class="img-fluid rounded mx-auto d-block" alt="Sweven Logo">
                <figcaption>The technology of your dreams.</figcaption>
            </figure>
        </div>

        <div class="col-lg-5 col-md-6 col-sm-12 d-flex align-items-center">
            <div class="register-form">
                <h3>Register</h3>
                <span>Join Sweven today.</span>
                <form method="POST" action="{{ route('register') }}">
                    {{ csrf_field() }}
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" id="name" value="{{ old('name') }}" placeholder="Name" required>
                        @if ($errors->has('name'))
                        <span class="error">
                            {{ $errors->first('name') }}
                        </span>
                        @endif
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="username" name="username" value="{{ old('username') }}" placeholder="Username" required>
                        @if ($errors->has('username'))
                        <span class="error">
                            {{ $errors->first('username') }}
                        </span>
                        @endif
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" id="email" name="email" value="{{ old('email') }}" placeholder="Email" required>
                        @if ($errors->has('email'))
                        <span class="error">
                            {{ $errors->first('email') }}
                        </span>
                        @endif
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="password" aria-describedby="passwordAdvice" placeholder="Password" required>
                        <!--<small id="passwordAdvice" class="form-text text-muted">Your password must be atleast 8 char long, blablabla</small>-->
                        @if ($errors->has('password'))
                        <span class="error">
                            {{ $errors->first('password') }}
                        </span>
                        @endif
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" name="password_confirmation" placeholder="Repeat password" required>
                    </div>
                    <input type="submit" class="black-button" value="Create Account"></input>
                </form>
                <span class="float-right">Have an account?
                    <a href="{{ url('/login')}}">Login</a>
                </span>
            </div>
        </div>
    </div>
    </div>
</div>
</main>
{{--<form method="POST" action="{{ route('register') }}">
    {{ csrf_field() }}

    <label for="name">Teste</label>
    <input id="name" type="text" name="name" value="{{ old('name') }}" required autofocus>
    @if ($errors->has('name'))
      <span class="error">
          {{ $errors->first('name') }}
      </span>
    @endif

    <label for="email">E-Mail Address</label>
    <input id="email" type="email" name="email" value="{{ old('email') }}" required>
    @if ($errors->has('email'))
      <span class="error">
          {{ $errors->first('email') }}
      </span>
    @endif

    <label for="password">Password</label>
    <input id="password" type="password" name="password" required>
    @if ($errors->has('password'))
      <span class="error">
          {{ $errors->first('password') }}
      </span>
    @endif

    <label for="password-confirm">Confirm Password</label>
    <input id="password-confirm" type="password" name="password_confirmation" required>

    <button type="submit">
      Register
    </button>
    <a class="button button-outline" href="{{ route('login') }}">Login</a>
</form>--}}
@endsection
