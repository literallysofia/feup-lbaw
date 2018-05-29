function deleteReview(review, id, product_id) {

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    action = product_id+"/review";
    let review_data = {};
    review_data.id = id;

    
    $.ajax({
        type: "DELETE",
        url: action,
        data: review_data,
        dataType: 'text',
        success: function (data) {
            final = JSON.parse(data);
            let reviewO = $(review).closest('.review-item');
            reviewO.next().remove();
            reviewO.remove();
            $("#reviews_counter").text("/"+final.Reviews);
            $("#give_opinion_form").attr("onsubmit", "return newOpinion("+product_id+")");
            let opinion = document.createElement('div');
            opinion.innerHTML = '<hr class="my-4"><div id="opinion_product" class="d-flex flex-row justify-content-end col-12"><input type="button" class="col-lg-3 col-xl-3 col-md-5 col-sm-6 col-xs-12" value="Give your Opinion" data-toggle="modal" data-target="#giveOpinionModal"></input></div>';
            let reviews = document.getElementById("reviews");
            reviews.appendChild(opinion);
        
        },
        error: function (data) {
            final = JSON.parse(data.responseText);
            alert("Error: " + final.Message);
        }
    });
    return false;
}

$(document).ready(function(){    

    update_stars();
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

function update_stars() {
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
}



function newOpinion(product_id){
    

    return DBreview("POST", product_id);
    
}

function editReview(product_id, id, title, content, score) {
    console.log(title);
    console.log(content);
    $("#giveOpinionModal #opinion_rate").val(score);
    setNewRate(score);
    $("#giveOpinionModal #review_title").val(title);
    $("#giveOpinionModal #review_text").val(content);
    $("#give_opinion_form").attr("onsubmit", "return updateReview("+product_id+", "+id+")");
}

function updateReview(product_id, id) {

    return DBreview("PUT", product_id, id);


}

function DBreview(type, product_id, id) {
    
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

    action = product_id+"/review";

    review_data = {};
    if(id != null) {
        review_data.id = id;
    }
    review_data.score=inputStars.value;
    review_data.title = inputTitle.value;
    review_data.content = content.value;

    
    $.ajax({
        type: type,
        url: action,
        data: review_data,
        dataType: 'text',
        success: function (data) {
            let final = JSON.parse(data);
            let reviews = final.Reviews;
            let template = document.getElementById('template').innerHTML;
            let design = document.getElementById("reviews");
            design.innerHTML = "";
            console.log(reviews);
            for(let i=0; i<reviews.length; i++){
                let html = document.createElement("div");
                if(i == reviews.length-2) {
                    reviews[i].last = true;
                }
                html.innerHTML = Mustache.render(template, reviews[i]);
                design.appendChild(html);
                console.log(design);
            }
            $("#giveOpinionModal").modal("hide");
            $("#reviews_counter").text("/"+final.Total);
            update_stars();
            
        },
        error: function (data) {
            let final = JSON.parse(data.responseText);
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

function rateText2(text) {
    let rate_text = document.getElementById("rate_text");
    if(rate_text != null){
        rate_text.innerHTML = text;
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


function setNewRate(score) {
    let stars;
    console.log(score);
    if((stars = document.querySelectorAll('#review_stars .stars-inner .fas')) != null) {
        for(let i=0; i<=score; i++) {
            $(stars[stars.length-i]).addClass('selected-star');
            if(stars.length-i == score) {
                rateText2($(stars[i]).attr("title"));
            }
        }
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