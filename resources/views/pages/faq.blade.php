@extends('layouts.app')

@section('title','Faq')

@section('content')

@include('partials.breadcrumbs', $data = array('FAQs' => ''))
<div class="container">
            <h1>Frequently Asked Questions</h1>
            
            <div class="section-container faq">
            @foreach($faqs as $faq)
                    <div class="question">
                        <p class="font-weigth-bold">{{$faq->question}}</p>
                        <p> {{$faq->answer}} </p>
                    </div>
            @endforeach 
            </div>
</div>