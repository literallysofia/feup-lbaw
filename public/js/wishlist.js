$(document).ready(isEmpty());

function isEmpty() {
    let products = document.querySelectorAll(".section-container > form");
    if (products[0] == null) {
        document.getElementsByClassName("section-container")[0].innerHTML = "<p style='text-align:center'>You don't have any products in your wishlist.";
        return true;
    } else if(products.length == 1) {
        $(products[0]).next().remove();
    }
    return false;
}


function removeDesignProduct(obj) {

    $(obj).closest("form").next().remove();
    $(obj).closest("form").remove();
    isEmpty();
}

function deleteProduct(obj, id) {
    

    if(!confirm('Are you sure you want to remove this product?'))
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
            removeDesignProduct(obj);
        },
        error: function (data) {
            alert("Error: " + data.responseText);
            console.log('Error: ', data);
        }
    });
    return false;
}