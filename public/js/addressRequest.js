function clearAddressValues() {
    var form = $("#add_address_modal .form-group input");
    for (var i = 0; i < form.length; i++) {
        form.get(i).value = '';
    }
}

function deleteAddress(e){

    var my_url = '/profile/address';

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });
    
    e.preventDefault();
    var address = e.target.parentElement.parentElement.id;
    var addressId = address.substring(address.indexOf('-')+1,address.length);
    console.log(addressId);
    var my_data = {
        'addressId' : addressId
    }
    var type = 'PUT';
   
    $.ajax({
        type: type,
        url: my_url,
        data: my_data,
        success: function (data) {
            console.log(data);
            var cards = $('#addresses_cards')[0].children;
            console.log(cards);
            for(let i = 0; i < cards.length ; i++){
                if(cards[i].children[0].id === address){
                    console.log(i);
                    cards[i].remove();
                }
            }
        },
        error: function (data) {
            alert('Error deleting address,please try again!');
            console.log('Error: ', data);
        }
    });
}

function addDeleteAction(){
    for(let i = 0; i< $('.btn-deleteAddress').length;i++){
        $('.btn-deleteAddress')[i].addEventListener('click',deleteAddress);
    }
}

$(document).ready(function () {
    
    addDeleteAction();

    $("#add_address_form").submit(function (e) {

        e.preventDefault();

        var fullurl = window.location.href;
        var my_url = '/profile/address'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var formFills = $("#add_address_modal .form-group input");
        var city = $("#add_address_modal .form-group #cities_selector").get(0);
        var country = $("#add_address_modal .form-group #countries_selector").get(0);
        console.log(city.options[city.selectedIndex].value);
        var type = "POST";
        var my_data = {
            'addressName': formFills.get(0).value,
            'street': formFills.get(1).value,
            'postalCode': formFills.get(2).value,
            'countryId': country.options[country.selectedIndex].value,
            'cityId': city.options[city.selectedIndex].value
        }

        if (my_data.addressName === '' || my_data.street === '' || my_data.postalCode === '') {
            return false;
        }

        $.ajax({
            type: type,
            url: my_url,
            data: my_data,
            dataType: 'json',
            success: function (data) {

                console.log(data);
                $('#addresses_cards')[0].children[$('#addresses_cards')[0].children.length - 1].remove();

                $('#addresses_cards')[0].innerHTML += '<div class="mt-4 col-md-6 col-lg-3">'
                    + '<div id="address-' + data.address.id+ '"class="box d-flex flex-column">'
                    + '<div class="d-flex flex-row address-header">'
                    + '<h6>' + data.address.name + '</h6>'
                    + '<i class="fas fa-trash-alt ml-auto btn-deleteAddress"></i></div>'
                    + '<h6>' + data.address.street + ', ' + data.address.postal_code + '</h6>';
                + '</div></div>';

                var addCard = '<div class="mt-4 col-md-6 col-lg-3">' +
                    '<div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#add_address_modal">' +
                    'Add Address' +
                    '</div>' +
                    '</div>';

                $('#addresses_cards')[0].innerHTML += addCard;

                $('#add_address_modal').modal('hide');

                console.log($('#addresses_cards')[0].children);
                addDeleteAction();
                clearAddressValues();
            },
            error: function (data) {
                alert('Error adding address,please try again!');
                console.log('Error: ', data);
            }
        });
    });
});

function filterCities(country) {

    let selector = document.getElementById("cities_selector");
    selector.value = selector.options[0].value;
    if (selector != null) {
        let options = selector.getElementsByTagName("option");
        if (options != null) {
            for (let i = 0; i < options.length; i++) {
                if (country.value != null && options[i].getAttribute('data-value') != country.value) {
                    options[i].setAttribute("hidden", true);
                    options[i].disabled = true;
                } else if (options[i].getAttribute("hidden") == true) {
                    options[i].setAttribute("hidden", false);
                    options[i].disabled = false;
                }
            }
        }
    }
}