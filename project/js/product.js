
// change this to adjust the rating display
var bvTireRating = 4.5;
// multiply by 20 to get percentage
var starRating = (bvTireRating+0.05)*20;
// set the width of the stars
$('.stars-inner').width(starRating+'%'); 




let stars_rate = document.querySelectorAll("#review_stars .stars_inner i");
let rate_text = document.getElementById("rate_text");
if(stars_rate != null) {
    for(let i=0; i<stars_rate.length; i++) {
        stars_rate[i].addEventListener('mouseover', rateText);
        stars_rate[i].addEventListener('click', setRate);
    }
}

function rateText() {
    if(this.id != null && rate_text != null){
        switch(this.id) {
            case "rate5":
                rate_text.innerHTML = "Excellent";
                break;
            case "rate4":
                rate_text.innerHTML = "Good";
                break;
            case "rate3":
                rate_text.innerHTML = "Average";
                break;
            case "rate2":
                rate_text.innerHTML = "Poor";
                break;
            case "rate1":
                rate_text.innerHTML = "Terrible";
                break;
        }
    }
}



/**
 * To get rate value just use rate variable
 */
function setRate() {
    if(this.id != null) {
        console.log(this.id);
        let rate = this.id.match(/[0-9]/);
        console.log(rate);
        if(document.querySelector('#review_stars .stars_inner') != null) {
            if($(this).prevAll('.fas').hasClass('selected_star')) {
                $(this).prevAll('.fas').removeClass('selected_star');
            }
            $(this).addClass('selected_star');
            $(this).nextAll('.fas').addClass('selected_star');
        }
    }
}

$("#giveOpinionModal").on("hidden.bs.modal", function(){
    if($(stars_rate).hasClass('selected_star'))
        $(stars_rate).removeClass('selected_star');
    
    rate_text.innerHTML = "";
    $('#giveOpinionModal input[type="text"]').val("");
    $("#giveOpinionModal textarea").val("");
    
});


