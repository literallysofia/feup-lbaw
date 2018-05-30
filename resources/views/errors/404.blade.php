@extends('layouts.app')

@section('title', 'Sweven | Error')

@section('content')

@include('partials.breadcrumbs', $data = array('Error' => ''))

<main>
    <div class="container">
       <div class="section-container">
            <h1 align="center">ERROR 404: Page Not Found</h1>
        </div>
    </div>
</main>

@endsection