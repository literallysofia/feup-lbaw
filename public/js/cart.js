function increment(obj, quantity_aval) {
    let quantity = $(obj).parent().prev();
    if(quantity.val() < 1 || quantity.val() >= quantity_aval) return;
    quantity.val(parseInt(quantity.val())+1);
    return false;
}

function decrement(obj, quantity_aval) {
    let quantity = $(obj).parent().next();
    if(quantity.val() <= 1) return;
    quantity.val(parseInt(quantity.val())-1);
    return false;
}


function update_total(selected_obj){
    let delivery_price = selected_obj.getAttribute('data');
    let subtotal = document.getElementById("subtotal_price");
    if(subtotal != null && subtotal.getAttribute('value') != null && delivery_price != null){
        subtotal = subtotal.getAttribute('value');
        $("#total_price").html((parseFloat(delivery_price)+parseFloat(subtotal))+" €");
    }
}


function update_quantity() {
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    
    $.ajax({
        type: "PATCH",
        url: delete_product,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            let final = JSON.parse(data);
            alert("Done: " + final.Message);
            removeDesignProduct(obj);
            $("#subtotal_price").html(final.Price+"€");
        },
        error: function (data) {
            let final = JSON.parse(data.responseText);
            alert("Error: " + final.Message);
            console.log('Error: ', data);
        }
    });
}

$(document).ready(function(){
    
    isEmpty();

    $('#quantity').on('change blur',function(){

        if($(this).val().trim().length === 0){
          $(this).val(1);
        } else {
        }
    });
});

function isEmpty() {

    let products = document.querySelectorAll(".cart-item");
    if (products[0] == null) {
        document.getElementsByClassName("section-container")[0].innerHTML = "<p style='text-align:center'>You don't have any product in your cart :-(";
        return true;
    }
    return false;
}

function removeDesignProduct(obj) {


    $(obj).closest(".cart-item").next().remove();
    $(obj).closest(".cart-item").remove();
    isEmpty();
}

function deleteProduct(obj, id) {
    

    if(!confirm('are you sure you want to remove this product?'))
        return false;
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    let product_data = {};
    product_data.id = id;

    let delete_product = "cart";
    
    $.ajax({
        type: "DELETE",
        url: delete_product,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            let final = JSON.parse(data);
            alert("Done: " + final.Message);
            removeDesignProduct(obj);
            $("#subtotal_price").html(final.Price+"€");
        },
        error: function (data) {
            let final = JSON.parse(data.responseText);
            alert("Error: " + final.Message);
            console.log('Error: ', data);
        }
    });
    return false;
}