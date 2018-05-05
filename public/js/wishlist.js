$(document).ready(isEmpty());

function isEmpty() {

    if (document.querySelector(".section-container > form") == null) {
        document.getElementsByClassName("section-container")[0].innerHTML = "<p style='text-align:center'>You don't have products in your wishlist :-(";
    }
    return false;
}

function addToCart(event, id) {
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    let product_data = {};
    product_data.id = id;

    let insert_cart = "cart";
    
    $.ajax({
        type: "POST",
        url: insert_cart,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            alert("Done: " + data);
            console.log(data);
            $(event).next().remove();
            $(event).remove();
            isEmpty();
        },
        error: function (data) {
            alert("Error: " + data.responseText);
            console.log('Error: ', data);
        }
    });
    return false;

}

function deleteProduct(event, id) {
    

    if(!confirm('are you sure you want to remove this product?'))
        return false;
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    let product_data = {};
    product_data.id = id;

    let delete_product = "wishlist";
    
    $.ajax({
        type: "DELETE",
        url: delete_product,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            alert("Done: " + data);
            console.log(data);
            $(event).closest("form").next().remove();
            $(event).closest("form").remove();
            isEmpty();
        },
        error: function (data) {
            alert("Error: " + data.responseText);
            console.log('Error: ', data);
        }
    });
    return false;
}