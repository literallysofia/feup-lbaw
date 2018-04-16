@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array('FAQs' => ''))
<main>
<div class="container">
            <h1>Frequently Asked Questions</h1>
            
            <div class="section-container faq">
                @each('partials.question', $faqs,'faq')
            </div>
</div>
</main>
@endsection