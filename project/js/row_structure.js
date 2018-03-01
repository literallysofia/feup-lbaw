let row = document.getElementsByClassName("cart-item");
if(row.length == 0) {
    row = document.getElementsByClassName("review_item");
    console.log(row[0]);
}
$(document).ready(function(){
    setRowStructure();
    $(window).resize(function() {setRowStructure()} );
});


function setRowStructure() {
    if(row.length != 0) {
        if($(window).width() >= 576 || $(document).width() >= 576){
        
            if(!row[0].classList.contains("flex-row")) {
                for(let i=0; i<row.length; i++) {
                    row[i].className += " d-flex flex-row";
                }
            }

        } else {
            if (row[0].classList.contains("d-flex") && row[0].classList.contains("flex-row")) {
                for(let i=0; i<row.length; i++) {
                    row[i].classList.remove("d-flex");
                    row[i].classList.remove("flex-row");
                    
                }
            }
        }
    }

}