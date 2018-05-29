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
            alert("Done: " + data);
            console.log(data);
            if (obj != null)
                removeDesignProduct(obj);
        },
        error: function (data) {
            alert("Error: " + data.responseText);
            console.log('Error: ', data);
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
            alert("Done: " + data);
            console.log(data);
        },
        error: function (data) {
            alert("Error: " + data.responseText);
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