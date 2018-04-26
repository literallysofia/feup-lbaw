$(document).ready(function () {

    $("#profile_form").submit(function (e) {

        e.preventDefault();

        my_url = '/profile/edit';

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        e.preventDefault();

        var formFills = $("#profile_form .form-group input");
        var type = "PUT";
        var my_data = {};

        if (formFills.get(0).value !== '') my_data.name = formFills.get(0).value;
        if (formFills.get(1).value !== '') my_data.username = formFills.get(1).value;
        if (formFills.get(2).value !== '') my_data.email = formFills.get(2).value;
        if (formFills.get(3).value !== '') my_data.old_password = formFills.get(3).value;
        if (formFills.get(4).value !== '') my_data.new_password = formFills.get(4).value;

        console.log(my_data.old_password + '\n' + my_data.new_password + '\n' + my_data.confirm_password + '\n');

        if (my_data.old_password !== '')
            if (my_data.new_password === '' || my_data.new_password !== my_data.confirm_password)
                return false;

        $.ajax({
            type: type,
            url: my_url,
            data: my_data,
            dataType: 'text',
            success: function (data) {
                alert("Done: " + data);
                console.log(data);
            },
            error: function (data) {
                alert("Error: " + data.responseText);
                console.log('Error: ', data);
            }
        });
    });
});