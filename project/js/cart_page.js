let cart_item = document.getElementsByClassName("cart-item");
$(document).ready(function(){
    setCartItemsStructure();
    $(window).resize(function() {setCartItemsStructure()} );
});


function setCartItemsStructure() {
    if(cart_item != null) {
        if($(window).width() >= 576 || $(document).width() >= 576){
        
            if(!cart_item[0].classList.contains("flex-row")) {
                for(let i=0; i<cart_item.length; i++) {
                    cart_item[i].className += " d-flex flex-row";
                }
            }

        } else {
            if (cart_item[0].classList.contains("d-flex") && cart_item[0].classList.contains("flex-row")) {
                for(let i=0; i<cart_item.length; i++) {
                    cart_item[i].classList.remove("d-flex");
                    cart_item[i].classList.remove("flex-row");
                    
                }
            }
        }
    }

}