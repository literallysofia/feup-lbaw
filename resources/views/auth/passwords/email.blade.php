@extends('layouts.app')

@section('content')

<main>
    <div class="container mt-5">
        <h1>Reset Password</h1>
        <div class="section-container contact">
        @if (session('status'))
            <div class="alert alert-success">{{ session('status') }}</div>
        @endif

        <p>Enter your email address and we will send you a link to reset your password.</p>

        <form class="contact-form" method="POST" action="{{ route('password.email') }}">
            {{ csrf_field() }}
            <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                <label for="email">YOUR EMAIL (required)</label>
                <input id="email" type="email" class="form-control reset-field" name="email" value="{{ old('email') }}" placeholder="Email" required>
                @if ($errors->has('email'))
                    <span class="help-block"><strong>{{ $errors->first('email') }}</strong></span>
                @endif
            </div>
            <input type="submit" class="black-button" value="Send">
        </form>
    </div>
</main>

@endsection