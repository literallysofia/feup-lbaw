
function deleteFaq(e){
    e.preventDefault();

    var faq = e.target.parentElement.id;
    var faqId = faq.substring(faq.indexOf('-')+1,faq.length);

    alert("delete faq " + faqId);
}


function addDeleteFaqAction(){
    for(let i = 0; i< $('.btn-deleteFaq').length;i++){
        $('.btn-deleteFaq')[i].addEventListener('click',deleteFaq);
    }
}


$(document).ready(function () {

    addDeleteFaqAction();

});