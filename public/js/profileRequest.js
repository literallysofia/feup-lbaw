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

        var form_fills = $("#profile_form .form-group input");
        var type = "PUT";
        var my_data = {};

        if (form_fills.get(0).value !== '') my_data.name = form_fills.get(0).value;
        if (form_fills.get(1).value !== '') my_data.username = form_fills.get(1).value;
        if (form_fills.get(2).value !== '') my_data.email = form_fills.get(2).value;
        if (form_fills.get(3).value !== '') my_data.old_password = form_fills.get(3).value;
        if (form_fills.get(4).value !== '') my_data.new_password = form_fills.get(4).value;
        if (form_fills.get(5).value !== '') var confirm_password = form_fills.get(5).value;

        console.log(my_data.old_password + '\n' + my_data.new_password + '\n' + confirm_password + '\n');

        if (my_data.old_password !== '')
            if (my_data.new_password === '' || my_data.new_password !== confirm_password)
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

function boldUnboldLine(line) {

    let containsClass = line.classList.contains("unbold");
  
    if (containsClass) {
      line.classList.remove("unbold");
      line.classList.add("bold");
    } else {
      line.classList.remove("bold");
      line.classList.add("unbold");
    }
  }
  
  function boldUnboldText(text) {
  
    line = text.parentElement;
  
    let containsClass = line.classList.contains("unbold");
  
    if (containsClass) {
      line.classList.remove("unbold");
      line.classList.add("bold");
    } else {
      line.classList.remove("bold");
      line.classList.add("unbold");
    }
  }