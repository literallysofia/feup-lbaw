function addToCart(obj, id) {

    ajaxSetup();

    let product_data = {};
    product_data.id = id;

    let insert_cart = "/cart";

    $.ajax({
        type: "POST",
        url: insert_cart,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            //alert("Done: " + data);
            console.log(data);

            $("#cart-error").css('display','none');            
            $("#cart-success").css('display','block');
            $("#cart-success").text(data);

            if (obj != null)
                removeDesignProduct(obj);
        },
        error: function (data) {
            //alert("Error: " + data.responseText);
            console.log('Error: ', data);

            $("#cart-success").css('display','none');            
            $("#cart-error").css('display','block');
            $("#cart-error").text(data.responseText);
        }
    });
    return false;
}

function addToWishlist(id) {

    ajaxSetup();

    let product_data = {};
    product_data.id = id;

    let insert_wishlist = "/wishlist";

    $.ajax({
        type: "POST",
        url: insert_wishlist,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            //alert("Done: " + data);
            console.log(data);
            $("#wishlist-error").css('display','none');            
            $("#wishlist-success").css('display','block');
            $("#wishlist-success").text(data);
        },
        error: function (data) {
            $("#wishlist-success").css('display','none');            
            $("#wishlist-error").css('display','block');
            $("#wishlist-error").text(data.responseText);
            console.log('Error: ', data);
        }
    });
    return false;
}

function ajaxSetup() {
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
}

$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });

    $('#back-to-top').click(function () {
        $('#back-to-top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 800);
        return false;
    });

    $('#back-to-top').tooltip('show');
});