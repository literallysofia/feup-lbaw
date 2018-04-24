$(document).ready(function () {


    $("#profile_form").submit(function (e) {

        e.preventDefault();

        //TODO check profile update labels restrictions as email password restricitions with regex

        my_url = '/profile/edit';

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var formFills = $("#profile_form .form-group input");
        var type = "PUT";
        var my_data = {
            'name': formFills.get(0).value,
            'username': formFills.get(1).value,
            'email': formFills.get(2).value,
            'old_password': formFills.get(3).value,
            'new_password': formFills.get(4).value,
            'confirm_password': formFills.get(5).value
        }

        console.log(my_data.old_password + '\n' + my_data.new_password + '\n' + my_data.confirm_password + '\n')

        if (my_data.name != '' && !my_data.name.match("/^[a-z ,.'-]+$/i")) {
            //todo error
            return false;
        }

        if (my_data.username != '' && !my_data.username.match('/^[a-zA-Z0-9]+$/')) {
            //todo error
            return false;
        }

        if (my_data.old_password !== '')
            if (my_data.new_password === '' || my_data.new_password !== my_data.confirm_password)
                return false;
        if (!my_data.new_password.match('/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/')) {
            //todo error
            return false;
        }

        $.ajax({
            type: type,
            url: my_url,
            data: my_data,
            dataType: 'text',
            success: function (data) {
                console.log(data);
            },
            error: function (data) {
                console.log('Error: ', data);
            }
        });
    });
});