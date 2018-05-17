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
            var cards = $('.categories-cards')[0].children;
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


function addDeleteCategoryAction(){
    for(let i = 0; i< $('.btn-deleteCategory').length;i++){
        $('.btn-deleteCategory')[i].addEventListener('click',deleteCategory);
    }
}

function addEntryAction(){
    for(let i = 0; i< $('.btn-addEntryCategory').length;i++){
        $('.btn-addEntryCategory')[i].addEventListener('click', event => {
            var entryDefault = event.target.parentElement.previousElementSibling;
            var newEntry =  entryDefault.cloneNode(true);
            newEntry.classList.remove('default');
            newEntry.style.visibility="visible";    
            buttons = event.target.parentElement;
            $(newEntry).insertBefore(entryDefault);
       });
     
    }
}


function saveCategoryAction(){
    for(let i = 0; i< $('.btn-saveCategory').length;i++){
        $('.btn-saveCategory')[i].addEventListener('click', event => {

            var category = event.target.parentElement.parentElement.id;
            var categoryId = category.substring(category.indexOf('-')+1,category.length);

            var isNavBar = $(event.target).parent().siblings('.category-header').find('div div label input[type="checkbox"]').is(':checked');        

            var select_checkboxs = $(event.target).parent().siblings('.select-checkbox');
            var data = [];

            for(let j = 0; j< select_checkboxs.length;j++){

                var propertyValue = select_checkboxs.eq(j).children('select').find(":selected").val().trim();
                var required = select_checkboxs.eq(j).find('div label input[type="checkbox"]').is(':checked');

                if(propertyValue != ""){
                    var propertyId = propertyValue.substring(propertyValue.indexOf('-')+1,propertyValue.length);
                    
                    console.log("Property: " + propertyId + "    Required: " + required);
                    
                    data.push({
                        'propertyId': propertyId,
                        'required': required
                    });
                   
                }    
            }

            console.log(data);

            var fullurl = window.location.href;
            var my_url = '/admin/category_properties'

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            var type = "POST";
    
            $.ajax({
                type: type,
                url: my_url,
                data: {
                    'categoryId' : categoryId,
                    'isNavBar' : isNavBar,
                    'categoryProperties': JSON.stringify(data)},
                dataType: 'json',
                success: function (data) {

                    console.log(data.category);

                    categoryUpdated = document.getElementById("category-"+ data.category.id);

                                     

                    categoryUpdated.innerHTML = 
                    '<div class="category-header"><h6>' +
                    data.category.name +
                    '</h6><div class="d-flex flex-row"><div class="checkbox-container form-check d-flex"><label class="form-check-label"></label>';

                    var navCheckbox = categoryUpdated.querySelector( 'label.form-check-label');

                    if(data.category.is_navbar_category=="true")
                        navCheckbox.innerHTML = 'Show on the navigation menu <input type="checkbox" class="form-check-input" checked> <span class="checkmark"></span>'; 
                    else
                        navCheckbox.innerHTML = 'Show on the navigation menu <input type="checkbox" class="form-check-input"> <span class="checkmark"></span>';  
                    
                    var el = categoryUpdated.querySelector( '.category-header div');

                    el.innerHTML += '<i class="fas fa-trash-alt ml-auto btn-deleteCategory"></i>';

                    //default entry
                    var newEntry = document.getElementsByClassName("select-checkbox default")[0];  

                    categoryUpdated.innerHTML += '<div class="select-checkbox default" style="visibility: hidden;">'+
                    newEntry.innerHTML +
                    '</div>'+
                    '<div class="entry-buttons"><input class="btn-addEntryCategory" type="button" value="Add Entry"></input><input type="button" value="Add Product"></input><input class="btn-saveCategory black-button" type="button" value="Save"></input> </div>';

                    addDeleteCategoryAction();
                    addEntryAction();
                    saveCategoryAction();

                    //TODO: add navbar category to navbar
                    //TODO: delete das category properties que se colocaram a none
                    //TODO: delete das repetidas

                },
                error: function (data) {

                    alert('Error saving category, please try again!');
                    console.log('Error: ', data);
                   
                }
            });

        });
    }
}

$(document).ready(function () {
    
    addDeleteCategoryAction();

    addEntryAction();

    saveCategoryAction();

    $("#add_category_form").submit(function (e) {

        e.preventDefault();

        var fullurl = window.location.href;
        var my_url = '/admin/category'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

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
                    var newEntry = document.getElementsByClassName("select-checkbox default")[0];
                    
                    $('.categories-cards')[0].innerHTML += ' <div class="mt-4 col-md-6 col-lg-4"> <div id="category-' +
                    data.category.id +
                    '" class="box d-flex flex-column"> <div class="category-header"><h6>' +
                    data.category.name +
                    '</h6><div class="d-flex flex-row"> <div class="checkbox-container form-check d-flex"> <label class="form-check-label">Show on the navigation menu <input type="checkbox" class="form-check-input"> <span class="checkmark"></span> </label> </div> <i class="fas fa-trash-alt ml-auto btn-deleteCategory"></i></div></div>' + 
                    '<div class="select-checkbox default" style="visibility: hidden;">'+
                    newEntry.innerHTML +
                    '</div>'+
                    '<div class="entry-buttons"><input class="btn-addEntryCategory" type="button" value="Add Entry"></input><input type="button" value="Add Product"></input><input class="btn-saveCategory black-button" type="button" value="Save"></input> </div>';

                    var addCard = '<div class="mt-4 col-md-6 col-lg-4"> <div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#add_category_modal"> Add Category </div> </div>';
    
                    $('.categories-cards')[0].innerHTML += addCard;
    
                    $('#add_category_modal').modal('hide');
    
                    console.log($('.categories-cards')[0].children);
                    nameFill.value='';

                    addDeleteCategoryAction();
                    addEntryAction();
                    saveCategoryAction();
                },
                error: function (data) {
                    alert('Error adding category, please try again!');
                    console.log('Error: ', data);
                }
            });

        }
        
    });
});