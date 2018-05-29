@extends('layouts.app')

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
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque vel ultricies lacus. Praesent fermentum
            vehicula augue a convallis. Nulla vel cursus augue. Integer ut sem sapien. Duis fermentum facilisis nisi,
            eu finibus urna viverra ac. Proin non sapien vitae lacus finibus porta eget nec justo. Sed est ante,
            interdum eget nunc sit amet, malesuada ultricies purus. In molestie nunc ut neque finibus, nec blandit
            tellus tincidunt. Maecenas iaculis ipsum at nisi maximus lobortis. Fusce rutrum mi bibendum odio hendrerit
            porttitor. Morbi semper felis hendrerit neque varius malesuada. Maecenas rutrum, mauris vel sagittis
            suscipit, turpis odio malesuada leo, non cursus urna arcu vitae felis.
            <br>Enjoy.</p>
        </div>
    </div>
</main>

@endsection