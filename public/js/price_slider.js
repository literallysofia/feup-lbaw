var rangeSlider = function () {
    var slider = $('.range-slider'),
        range = $('.range-slider__range'),
        value = $('.range-slider__value');

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
        var page = $(this).attr('href').split('page=')[1];
        var url = $(this).attr('href');
        getProducts(page);
        window.history.pushState('', '', url);
    });
});

function getProducts(page) {
    var my_url = '?page=' + page;

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
            $('#product-listing').html(response.products);
            $('.pagination-links').html(response.links);
        },
        error: function () {
            alert('Products could not be loaded.');
        }
    });
}