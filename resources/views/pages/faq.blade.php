@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array('FAQs' => ''))
<div class="container">
            <h1>Frequently Asked Questions</h1>
            
            <div class="section-container faq">
            @foreach($faqs as $faq)
                @each('partials.question', $faqs,'faq')
            @endforeach 
            </div>
</div>