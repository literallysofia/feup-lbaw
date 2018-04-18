function clearAddressValues() {
    var form = $("#addAddressModal .form-group input");
    for (var i = 0; i < form.length; i++) {
        form.get(i).value = '';
    }
}

$(document).ready(function () {
    console.log($('#addresses_cards')[0].children[0].children[0].id);
    for(let i = 0; i< $('.btn-deleteAddress').length;i++){
        $('.btn-deleteAddress')[i].addEventListener('click',function(e){

            console.log("Apaga");

            var my_url = '/profile/address';

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            e.preventDefault();
            var addressId = e.target.parentElement.parentElement.id;
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
                        if(cards[i].children[0].id == addressId){
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

            
        });
    }

    $("#btn-addAddress").click(function (e) {

        var fullurl = window.location.href;
        var my_url = '/profile/address'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var formFills = $("#addAddressModal .form-group input");
        var city = $("#addAddressModal .form-group #cities_selector").get(0);
        console.log(city.options[city.selectedIndex].value);
        var type = "POST";
        var my_data = {
            'addressName': formFills.get(0).value,
            'street': formFills.get(1).value,
            'postalCode': formFills.get(2).value,
            'cityId': city.options[city.selectedIndex].value
        }
        console.log()
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
                    + '<div class="box d-flex flex-column">'
                    + '<div class="d-flex flex-row address-header">'
                    + '<h6>' + data.address.name + '</h6>'
                    + '<i class="fas fa-trash-alt ml-auto"></i></div>'
                    + '<h6>' + data.address.street + ',' + data.address.postal_code + '</h6>';
                + '</div></div>';

                var addCard = '<div class="mt-4 col-md-6 col-lg-3">' +
                    '<div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#addAddressModal">' +
                    'Add Address' +
                    '</div>' +
                    '</div>';

                $('#addresses_cards')[0].innerHTML += addCard;

                $('#addAddressModal').modal('hide');
                console.log($('#addresses_cards')[0].children);
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