function deleteReview(review, id, product_id) {

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    action = id+"/review";
    let review_data = {};
    review_data.product_id = product_id;
    
    $.ajax({
        type: "DELETE",
        url: action,
        data: review_data,
        dataType: 'text',
        success: function (data) {
            final = JSON.parse(data);
            alert("Done: " + final.Message);
            let reviewO = $(review).closest('.review-item');
            reviewO.next().remove();
            reviewO.remove();
            $("#reviews_counter").text("/"+final.Reviews);
        },
        error: function (data) {
            final = JSON.parse(data.responseText);
            alert("Error: " + final.Message);
        }
    });
    return false;
}

$(document).ready(function(){
    
    let scores = document.querySelectorAll(".stars");
    if(scores != null) {
        for(let i=0; i<scores.length; i++) {
            let score_value = scores[i].querySelector("input[type='hidden']");
            if(score_value != null && score_value.value != null && isInteger(score_value.value)) {

                var starRating = parseFloat(score_value.value)*20;
                // set the width of the stars
                let stars;
                if((stars = scores[i].querySelector('.stars-inner')) != null){
                    stars.style.width = starRating+'%'; 
                }
            }
        }
    }    

    
    //set listeners to giveOpinion form
    let stars_rate = document.querySelectorAll("#review_stars .stars-outer .stars-inner i");
    let rate_text = document.getElementById("rate_text");
    if(stars_rate != null) {
        for(let i=0; i<stars_rate.length; i++) {
            stars_rate[i].addEventListener("mouseover",rateText);
            stars_rate[i].addEventListener('mouseout', resetRateText);
            stars_rate[i].addEventListener('click', setRate);
        }
    }

    $("#giveOpinionModal").on("hidden.bs.modal", function(){
        if($(stars_rate).hasClass('selected-star'))
            $(stars_rate).removeClass('selected-star');
        
        rate_text.innerHTML = "";
        $('#giveOpinionModal input[type="text"]').val("");
        $("#giveOpinionModal textarea").val("");
        $("#review_stars").css("border", "none");
        
    });

});



function newOpinion(id){
    
    let inputStars = document.getElementById("opinion_rate");
    let inputTitle = document.querySelector("#give_opinion_form input[type='text']");
    let content = document.querySelector("#give_opinion_form textarea");
    let stars = document.getElementById("review_stars");
    if(stars != null)
        stars.style.border = "none";
    let review_data = {};
    if(content.value == null || content.value == '' || inputTitle.value == null || inputTitle.value == '')
      return false;
    
    if(inputStars.value == null || inputStars.value == '' || !String(inputStars.value).match(/^([1-5])$/)) {
        if(stars != null) {
            stars.style.border = "thin solid red";
        }
        return false;
    }

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    action = id+"/review";

    review_data.score=inputStars.value;
    review_data.title = inputTitle.value;
    review_data.content = textarea.value;

    
    $.ajax({
        type: "POST",
        url: action,
        data: review_data,
        dataType: 'text',
        success: function (data) {
            final = JSON.parse(data);
            alert("Done: " + final.Message);
        },
        error: function (data) {
            final = JSON.parse(data);
            alert("Error: " + final.Message);
            console.log('Error: ', final);
        }
    });
    return false;
}




function rateText() {
    if($(this).attr("data-alt") != null && rate_text != null){
        rate_text.innerHTML = this.title;
        rate_text.style.visibility = "visible";
    }
}

function resetRateText() {
    let text = document.querySelector("#review_stars .stars-outer .stars-inner .selected-star");
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
        if(document.querySelector('#review_stars .stars-inner') != null) {
            if($(this).prevAll('.fas').hasClass('selected-star')) {
                $(this).prevAll('.fas').removeClass('selected-star');
            }
            $(this).addClass('selected-star');
            $(this).nextAll('.fas').addClass('selected-star');
        }
        console.log(rate);
        $("#opinion_rate").val(rate);
    }
}

function isInteger(x) {
    x = parseInt(x);
    return (typeof x === 'number') && (x % 1 === 0) && (x>= 1) && (x<=5);
}