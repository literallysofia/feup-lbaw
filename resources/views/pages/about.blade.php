@extends('layouts.app')

@section('title', 'Sweven | About')

@section('content')

@include('partials.breadcrumbs', $data = array('About' => ''))

<main>
    <div class="container">
        <h1>About</h1>
        <div class="section-container about">
            <figure>
                <img src="../assets/logo.svg" class="img-fluid rounded mx-auto d-block" alt="Sweven Logo">
                <figcaption>The technology of your dreams.</figcaption>
            </figure>
            <p>The purpose of this project was to develop a web application for an online tech store, called <strong>Sweven</strong>, which means a vision seen in sleep, a dream. From the Old English to the modern days, this word inspired us.
            In order to have a great product diversity, the store sells multiple tech brands and product types, such as smartphones, laptops, and tablets.
            Sweven is based on HTML5, JavaScript, and CSS. The Bootstrap framework was used to implement the user interface and when it comes to PHP, it was used the Laravel framework.<br><br>
            The platform has an adaptive design and a detailed navigation system by arranging the products through categories. In order to provide a reliable service, each product has a review section, which allows users to not only review the items they purchased but also to view other people's opinions. Each review includes a score and a short description, which results in the product to have an average score. Besides, users have the ability to save favorite products in a wishlist and view the history of all previous purchases. Finally, users are distributed in three groups with different permissions: administrators, unauthenticated and authenticated users.<br><br>
            This project was developed for the Database and Web Applications Laboratory (LBAW) class of the Master in Informatics and Computer Engineering (MIEIC) at the Faculty of Engineering at the University of Porto (FEUP), by Bárbara Sofia Silva, Carlos Miguel Freitas, Julieta Frade and Luís Martins in 2018.<br><br>
            Enjoy.</p>
        </div>
    </div>
</main>

@endsection
