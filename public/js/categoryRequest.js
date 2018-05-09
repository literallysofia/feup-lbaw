

function deleteCategory(e){

  var my_url = '/admin/category';

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    
    e.preventDefault();
    var category = e.target.parentElement.parentElement.parentElement.id;
    var categoryId = category.substring(category.indexOf('-')+1,category.length);
    console.log(categoryId);
    var my_data = {
        'categoryId' : categoryId
    }
    var type = 'PUT';
   
    $.ajax({
        type: type,
        url: my_url,
        data: my_data,
        success: function (data) {
            console.log(data);
            var cards = $('.categories-cards')[0].children;
            console.log(cards);
            for(let i = 0; i < cards.length ; i++){
                if(cards[i].children[0].id === category){
                    console.log(i);
                    cards[i].remove();
                }
            }
        },
        error: function (data) {
            alert('Error deleting categoy, please try again!');
            console.log('Error: ', data);
        }
    });
}


function addDeleteAction(){
    for(let i = 0; i< $('.btn-deleteCategory').length;i++){
        $('.btn-deleteCategory')[i].addEventListener('click',deleteCategory);
    }
}

$(document).ready(function () {
    
    addDeleteAction();

    $("#add_category_form").submit(function (e) {

        e.preventDefault();

        var fullurl = window.location.href;
        var my_url = '/admin/category'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var nameFill = document.getElementById("new_category");
        var type = "POST";

        if(nameFill!=null && nameFill.value!=null){

            var my_data = {
                'categoryName': nameFill.value,
            }
    
            if (my_data.categoryName === '') {
                return false;
            }
    
            $.ajax({
                type: type,
                url: my_url,
                data: my_data,
                dataType: 'json',
                success: function (data) {
    
                    console.log(data);
                    $('.categories-cards')[0].children[$('.categories-cards')[0].children.length - 1].remove();
    
                    $('.categories-cards')[0].innerHTML += ' <div class="mt-4 col-md-6 col-lg-4"> <div id="category-' +
                    data.category.id +
                    '" class="box d-flex flex-column"> <div class="category-header"><h6>' +
                    data.category.name +
                    '</h6><div class="d-flex flex-row"> <div class="checkbox-container form-check d-flex"> <label class="form-check-label">Show on the navigation menu <input type="checkbox" class="form-check-input"> <span class="checkmark"></span> </label> </div> <i class="fas fa-trash-alt ml-auto btn-deleteCategory"></i></div></div>' + 
                    '<div class="entry-buttons"><input type="button" value="Add Entry"></input><input type="button" value="Add Product"></input><input type="button" class="black-button" value="Save"></input> </div>';
    
                    var addCard = '<div class="mt-4 col-md-6 col-lg-4"> <div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#add_category_modal"> Add Category </div> </div>';
    
                    $('.categories-cards')[0].innerHTML += addCard;
    
                    $('#add_category_modal').modal('hide');
    
                    console.log($('.categories-cards')[0].children);
                    nameFill.value='';
                    addDeleteAction();
                },
                error: function (data) {
                    alert('Error adding category, please try again!');
                    console.log('Error: ', data);
                }
            });

        }
        
    });
});