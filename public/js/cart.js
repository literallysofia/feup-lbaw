function increment(obj, quantity_aval) {
    let quantity = $(obj).parent().prev();
    if(quantity.val() < 1 || quantity.val() >= quantity_aval) return;
    quantity.val(parseInt(quantity.val())+1);
    update_quantity(quantity);
    return false;
}

function decrement(obj, quantity_aval) {
    let quantity = $(obj).parent().next();
    if(quantity.val() <= 1) return;
    quantity.val(parseInt(quantity.val())-1);
    update_quantity(quantity);
    return false;
}

function update_total(selected_obj){
    let delivery_price = $(selected_obj).attr('data');
    let subtotal = $(".subtotal_price:eq(1)").attr("value");
    if (typeof subtotal !== typeof undefined && subtotal !== false && typeof delivery_price !== typeof undefined && delivery_price !== false) {
        let value = parseFloat(parseFloat(delivery_price)+parseFloat(subtotal)).toFixed(2)
        $("#total_price").html(value+" €");
        $("#total_price_input").val(value);
    }
}


function update_quantity(selected_obj) {
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    let product_data = {};
    product_data.id = parseInt($(selected_obj).attr("data-id"));
    product_data.quantity = parseInt($(selected_obj).val());

    let update_product = "cart";
    
    $.ajax({
        type: "PUT",
        url: update_product,
        data: product_data,
        dataType: 'text',
        success: function (data) {
            
            let final = JSON.parse(data);

            /* update subtotal variables */
            let value = parseFloat(final.Price).toFixed(2);
            $(".subtotal_price").text(value + " €");
            var subtotal = $(".subtotal_price:eq(1)").attr("value");
            if (typeof subtotal !== typeof undefined && subtotal !== false) {
                $(".subtotal_price:eq(1)").attr('value', value);
            }
            $("#total_price").html(value+" €");
            $("#total_price_input").val(value);
        },
        error: function (data) {
            let final = JSON.parse(data.responseText);
            alert("Error: " + final.Message);
            console.log('Error: ', data);
        }
    });
    return false;
}

$(document).ready(function(){
    
    isEmpty();

    $('.item_quantity').on('change blur',function(){

        if($(this).val().trim().length === 0){
          $(this).val(1);
        } else {
            let quantity = parseInt($(this).val());
            if(quantity < 0) {
                $(this).val(1);
            } else if(quantity > parseInt($(this).attr("data-value"))) {
                alert("There's not enough quantity of this product");
                $(this).val(1);
            }
        }
        update_quantity(this);

    });

    $(document).bind('ajaxStart', function(){
        $("#loader_page").show();
    }).bind('ajaxStop', function(){
        $("#loader_page").hide();
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