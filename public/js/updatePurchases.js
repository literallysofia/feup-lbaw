$(document).ready(function () {

    document.getElementById("table-save-button").addEventListener('click', event => {

        var purchases = document.getElementById("admin_purchases");

        var collapseLines = purchases.getElementsByClassName("collapse-line");

        var data = [];
        for(let j = 0; j< collapseLines.length;j++){
            var purchase =  collapseLines[j].childNodes[1];
            var purchase_id = purchase.id;
            var id = purchase_id.substring(purchase_id.indexOf('-')+1,purchase_id.length);

            var status = collapseLines[j].parentElement.previousElementSibling.getElementsByClassName("select-status")[0].value;
        
            data.push({
                'purchaseId': id,
                'status': status
            });  
        }

        var fullurl = window.location.href;
        var my_url = '/admin/admin_purchases'

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        var type = "POST";

        $.ajax({
            type: type,
            url: my_url,
            data: {'purchases':JSON.stringify(data)},
            dataType: 'json',
            success: function (data) {
                $("#purchases-error").css('display','none');            
                $("#purchases-success").css('display','block');
                $("#purchases-success").text(data.Message);
                $("#manage_purchases_title").attr("tabindex", -1).focus();
        
            },
            error: function (data) {

                $("#purchases-success").css('display','none');            
                $("#purchases-error").css('display','block');
                $("#purchases-error").text(data.Message);
                $("#manage_purchases_title").attr("tabindex", -1).focus();
               
            }
        });

    });
})