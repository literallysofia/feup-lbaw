$(document).ready(function () {

    console.log($('#addresses_cards')[0].children);

    $("#btn-addAddress").click(function (e) {

        var fullurl = window.location.href;
        var my_url = fullurl.substring(fullurl.indexOf("/profile"), fullurl.length);

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var formFills = $("#addAddressModal .form-group input");
        var type = "POST";
        var my_data = {
            'userId': my_url.substring(my_url.lastIndexOf('/') + 1, my_url.length),
            'addressName': formFills.get(0).value,
            'street': formFills.get(1).value,
            'postalCode': formFills.get(2).value,
            'city': formFills.get(3).value.trim(''),
            'country': formFills.get(4).value
        }

        if (my_data.addressName === '' || my_data.street === '' || my_data.postalCode === '' || my_data.city.equals === '' || my_data.country.equals === '') {
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
                    + '<h6>' + data.address.street + ',' + data.address.postal_code + ' ' + data.address.city_name + ',' + data.address.country_name + '</h6>';
                + '</div></div>';

                var addCard = '<div class="mt-4 col-md-6 col-lg-3">' +
                    '<div class="box d-flex flex-column last-card" data-toggle="modal" data-target="#addAddressModal">' +
                    'Add Address' +
                    '</div>' +
                    '</div>';

                $('#addresses_cards')[0].innerHTML += addCard;

                $('#addAddressModal').modal('hide');
                console.log($('#addresses_cards')[0].children);
            },
            error: function (data) {
                console.log('Error: ', data);
            }
        });
    });
});