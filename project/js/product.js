
// change this to adjust the rating display
var bvTireRating = 4.5;
// multiply by 20 to get percentage
var starRating = (bvTireRating+0.05)*20;
// set the width of the stars
$('.stars-inner').width(starRating+'%'); 




let stars_rate = document.querySelectorAll("#review_stars .stars_outer .stars_inner i");
let rate_text = document.getElementById("rate_text");
if(stars_rate != null) {
    for(let i=0; i<stars_rate.length; i++) {
        stars_rate[i].addEventListener("mouseover",rateText);
        stars_rate[i].addEventListener('mouseout', resetRateText);
        stars_rate[i].addEventListener('click', setRate);
    }
}

function rateText() {
    if($(this).attr("data-alt") != null && rate_text != null){
        rate_text.innerHTML = this.title;
        rate_text.style.visibility = "visible";
    }
}

function resetRateText() {
    let text = document.querySelector("#review_stars .stars_outer .stars_inner .selected_star");
    if(rate_text == null)
        return;
    if(text != null) {
        rate_text.innerHTML = text.title;
    } else {
        rate_text.innerHTML = "rate";
        rate_text.style.visibility = "hidden";
    }
}


/**
 * To get rate value just use rate variable
 */
function setRate() {
    if($(this).attr("data-alt") != null) {
        let rate = $(this).attr("data-alt");
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


