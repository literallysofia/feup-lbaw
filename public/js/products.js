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
        window.history.pushState('', '', url);
    });
    $(document).on('click', '.dropdown-menu a', function (e) {
        e.preventDefault();
        var url = $(this).attr('href');
        var sort = $(this).attr('href').split('sort=')[1];
        getProducts(url, sort);
        window.history.pushState('', '', url);
    });

});

function getProducts(my_url, sort = null) {

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $.ajax({
        url: my_url,
        type: 'GET',
        dataType: 'json',
        //data: {marchi: marchi},
        success: function (response) {
            $('#product-listing').html(response.products);
            $('.pagination-links').html(response.links);
        },
        error: function () {
            alert('Products could not be loaded.');
        }
    });
}