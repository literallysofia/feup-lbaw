


function deleteFaq(e){
    var my_url = '/admin/faq';

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    
    e.preventDefault();
    var faq = e.target.parentElement.id;
    var faqId = faq.substring(faq.indexOf('-')+1,faq.length);
    var my_data = {
        'faqId' : faqId
    }
    var type = 'DELETE';
   
    $.ajax({
        type: type,
        url: my_url,
        data: my_data,
        success: function (data) {
            
            //delete property card
            var cards = $('.faqs-cards')[0].children;
            for(let i = 0; i < cards.length ; i++){
                if(cards[i].children[0].id === faq){
                    cards[i].remove();
                }
            }

            $("#faqs-error").css('display','none');            
            $("#faqs-success").css('display','block');
            $("#faqs-success").text(data.Message);
            $("#manage_faqs_title").attr("tabindex", -1).focus();

        },
        error: function (data) {

            $("#faqs-success").css('display','none');
            $("#faqs-error").css('display','block');
            $("#faqs-error").text(data.Message);
            $("#manage_faqs_title").attr("tabindex", -1).focus();
        }
    });
}

function addDeleteFaqAction(){
    for(let i = 0; i< $('.btn-deleteFaq').length;i++){
        $('.btn-deleteFaq')[i].addEventListener('click',deleteFaq);
    }
}



$(document).ready(function () {

    addDeleteFaqAction();

    $("#add_faq_form").submit(function (e) {

        e.preventDefault();

        var fullurl = window.location.href;
        var my_url = '/admin/faq'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var questionFill = document.getElementById("new_question");
        var answerFill = document.getElementById("new_answer");
        
        var type = "POST";
        
        if(questionFill!=null && questionFill.value!=null && answerFill!=null && answerFill.value!=null){
            
            var my_data = {
                'question': questionFill.value,
                'answer': answerFill.value                
            }
    
            if (my_data.question === '' && my_data.answer === '' ) {
                return false;
            }
    
    
            $.ajax({
                type: type,
                url: my_url,
                data: my_data,
                dataType: 'json',
                success: function (data) {
    
                    $('.faqs-cards')[0].children[$('.faqs-cards')[0].children.length - 1].remove();


                    $('.faqs-cards')[0].innerHTML += ' <div class="mt-4"><div id="faq-' +
                    data.faq.id + 
                    '"class="box d-flex flex-column question-card"> <h6 class="font-weight-bold">' +
                    data.faq.question +
                    '</h6><p>' + 
                    data.faq.answer +
                    '</p><i class="fas fa-trash-alt align-self-end mt-auto btn-deleteFaq"></i></div></div>';
                    
                    var addCard = '<div class="mt-4"><div class="col box d-flex flex-column last-card"' +
                    'data-toggle="modal" data-target="#add_faq_modal"> Add FAQ</div></div>';
    
                    $('.faqs-cards')[0].innerHTML += addCard;
    
                    $('#add_faq_modal').modal('hide');
    
                    questionFill.value='';
                    answerFill.value='';                    
                    addDeleteFaqAction();

                    $("#faqs-error").css('display','none');    
                    $("#faqs-success").css('display','block');
                    $("#faqs-success").text(data.Message);
                    //$("#manage_faqs_title").attr("tabindex", -1).focus();

                },
                error: function (data) {
                    $("#faqs-success").css('display','none');                        
                    $("#faqs-error").css('display','block');
                    $("#faqs-error").text(data.Message);
                    $("#manage_faqs_title").attr("tabindex", -1).focus();

                }
            });
        }
        

    });



});