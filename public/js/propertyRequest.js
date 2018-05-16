

function deleteProperty(e){
    var my_url = '/admin/property';

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    
    e.preventDefault();
    var property = e.target.parentElement.id;
    var propertyId = property.substring(property.indexOf('-')+1,property.length);
    console.log(propertyId);
    var my_data = {
        'propertyId' : propertyId
    }
    var type = 'DELETE';
   
    $.ajax({
        type: type,
        url: my_url,
        data: my_data,
        success: function (data) {
            
            //delete property card
            var cards = $('.properties-cards')[0].children;
            for(let i = 0; i < cards.length ; i++){
                if(cards[i].children[0].id === property){
                    console.log(i);
                    cards[i].remove();
                }
            }

            //delete property select from categories
            var selected = $('select option:selected[value="property-' + propertyId + '"]');
            for(let i = 0; i < selected.length ; i++){
                selected[i].parentElement.parentElement.remove();
            }

            //delete property option on categories select
            var options = $('select option[value="property-' + propertyId + '"]');
            for(let i = 0; i < options.length ; i++){
                options[i].remove();
            }

        },
        error: function (data) {
            alert('Error deleting property, please try again!');
            console.log('Error: ', data);
        }
    });
}


function addDeletePropertyAction(){
    for(let i = 0; i< $('.btn-deleteProperty').length;i++){
        $('.btn-deleteProperty')[i].addEventListener('click',deleteProperty);
    }
}


$(document).ready(function () {

    addDeletePropertyAction();

    $("#add_property_form").submit(function (e) {

        e.preventDefault();

        var fullurl = window.location.href;
        var my_url = '/admin/property'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var nameFill = document.getElementById("new_property");
        var type = "POST";
        
        if(nameFill!=null && nameFill.value!=null){
            
            var my_data = {
                'propertyName': nameFill.value,
            }
    
            if (my_data.propertyName === '') {
                return false;
            }
    
    
            $.ajax({
                type: type,
                url: my_url,
                data: my_data,
                dataType: 'json',
                success: function (data) {
    
                    console.log(data);
                    $('.properties-cards')[0].children[$('.properties-cards')[0].children.length - 1].remove();
    
                    $('.properties-cards')[0].innerHTML += '<div class="mt-4 col-md-6 col-lg-3"> <div id=property-' +
                    data.property.id + 
                    ' class="box d-flex flex-column"> <h6>' +
                    data.property.name +
                    '</h6> <i class="fas fa-trash-alt align-self-end mt-auto btn-deleteProperty"></i> </div></div>';
                    
                    var addCard =  '<div class="mt-4 col-md-6 col-lg-3">' +
                    '<div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#add_property_modal">' +
                    'Add Property </div> </div>';
    
                    $('.properties-cards')[0].innerHTML += addCard;
    
                    $('#add_property_modal').modal('hide');
    
                    console.log($('.properties-cards')[0].children);
                    nameFill.value='';
                    addDeletePropertyAction();
                },
                error: function (data) {
                    alert('Error adding property, please try again!');
                    console.log('Error: ', data);
                }
            });
        }
        

    });



});