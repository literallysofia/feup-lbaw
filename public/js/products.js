var rangeSlider = function () {
    var slider = $('.price-slider'),
        range = $('.price-slider-range'),
        value = $('.price-slider-value');

    slider.each(function () {

        value.each(function () {
            var value = $(this).prev().attr('value') + ' €';
            $(this).html(value);
        });

        range.on('input', function () {
            $(this).next(value).html(this.value + ' €');
        });
    });
};

rangeSlider();

$(document).ready(function () {
    $(document).on('click', '.pagination a', function (e) {
        e.preventDefault();
        var url = $(this).attr('href');
        getProducts(url);
    });
    $(document).on('click', '.dropdown-menu a', function (e) {
        e.preventDefault();
        var url = $(this).attr('href');
        getProducts(url);
    });
    $(document).on('click', '.filters a', function (e) {
        e.preventDefault();
        var url = $(this).attr('href');
        var price = $('.price-slider-value').html().split(' ')[0];
        filterProducts(url, price);
    });
});

function getProducts(my_url) {

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $.ajax({
        url: my_url,
        type: 'GET',
        dataType: 'json',
        success: function (response) {
            $('#dropdown-sortby').html(response.dropdown);
            $('#filter-listing').html(response.filters);
            $('#product-listing').html(response.products);
            $('.pagination-links').html(response.links);
            window.history.pushState('', '', response.url);
            rangeSlider();
        },
        error: function () {
            alert('Products could not be loaded.');
        }
    });
}

function filterProducts(my_url, price) {

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $.ajax({
        url: my_url,
        type: 'GET',
        dataType: 'json',
        data: {
            'price_limit': price,
        },
        success: function (response) {
            $('#dropdown-sortby').html(response.dropdown);
            $('#filter-listing').html(response.filters);
            $('#product-listing').html(response.products);
            $('.pagination-links').html(response.links);
            window.history.pushState('', '', response.url);
            rangeSlider();
        },
        error: function () {
            alert('Products could not be loaded.');
        }
    });
}