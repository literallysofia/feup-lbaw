
function addPreviewListener(list) {
    if (list.children.length == 0 || list.children == null) {
        return
    }

    var images = [];

    for (var i = 0; i < list.children.length - 1; i++) {
        let imagePreview = list.children[i].firstChild.firstChild;
        let imageInput = list.children[i].firstChild.lastChild.firstChild.firstChild;
        images.push({ 'imagePreview': imagePreview, 'imageInput': imageInput });
    }

    console.log(images);
    images.forEach(function (item) {
        item.imageInput.addEventListener('change', function () {
            readUrl(item.imagePreview, item.imageInput);
        }, false);
    });

}

function addPhotoCard(e) {
    var list = $('.photo-cards')[0];
    list.children[list.children.length - 1].remove();
    var newCard = '<div class="mt-4 col-md-6 col-lg-3">' +
        '<div class="box d-flex flex-column ">' +
        '<div class="box d-flex flex-column align-items-center pt-0 pr-0 pl-0">' +
        '<img alt="Photo preview" class="img-fluid product_photo" id="imagePreview">' +
        '</div>' +
        '<div class="mt-auto">' +
        '<div class="custom-file">' +
        '<input type="file" class="imageUpload custom-file-input" id="imageUpload"accept=".png, .jpg, .jpeg">' +
        '<label class="custom-file-label" for="imageUpload">Choose file</label>' +
        '</div>' +
        '</div>' + '</div></div>';

    var addCard = '<div class="mt-4 col-md-6 col-lg-3" >' +
        ' <div class="box d-flex flex-column last-card" id="addPhoto"> ' +
        ' Add Photo ' +
        '</div> ' +
        '</div>';

    list.innerHTML += newCard + addCard;

    list.children[list.children.length - 1].addEventListener("click", addPhotoCard);

    var theFreshCard = list.children[list.children.length - 2];

    var imageInput = theFreshCard.firstChild.lastChild.firstChild.firstChild;



    var imagePreview = theFreshCard.firstChild.firstChild.firstChild;


    list = $('.photo-cards')[0];
    $('.imageUpload').on('change', function () {
        console.log("entrou");
        readUrl(this);
    });



}

function readUrl(input) {
    console.log("Added event ");

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {

            var preview = input.offsetParent.offsetParent.children[0].children[0].children[0];
            preview.src = e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }

}

function addEntryInput(event) {
    var input = document.createElement("INPUT");
    input.setAttribute("type", "text");
    input.setAttribute("class", "mb-2");
    event.target.offsetParent.firstElementChild.children[2].appendChild(input);
}

function getPhotosSrc() {
    var photosCards = $('.imageUpload');
    var photos_paths = [];
    for (let i = 0; i < photosCards.length; i++) {
        var src = photosCards[i].files[0];
        console.log(src);
        if (src != null)
            photos_paths.push(src);
    }
    return photos_paths;
}


function saveProduct(event) {
    event.preventDefault();

    var photos_src = getPhotosSrc();

    if(photos_src.length == 0)
        return false;

    var photos_files = new FormData();
    for (var i = 0; i < photos_src.length; i++) {
        photos_files.append(i, photos_src[i]);
    }

    var is_edit = false;
    if (event.target.id == "editProductButton")
        is_edit = true;
    var flag = false;
    if ($('#product_name').is(":invalid")) {
        $('#product_name').css('border', "2px solid #ff5555");
        //$('#product_name').focus();
        flag = true;
    }



    if ($('#add_product_price').is(":invalid")) {
        $('#add_product_price').css('border', "2px solid #ff5555");
        //$('#add_product_price').focus();
        flag = true;
    }



    if ($('#product_quantity').is(":invalid")) {
        $('#product_quantity').css('border', "2px solid #ff5555");
        //$('#product_quantity').focus();
        flag = true;
    }



    if ($('#product_brand').is(":invalid")) {
        $('#product_brand').css('border', "2px solid #ff5555");
        //$('#product_brand').focus();
        flag = true;
    }

    var product_name = $('#product_name').val();
    var product_price = $('#add_product_price').val();
    var product_quantity = $('#product_quantity').val();
    var product_brand = $('#product_brand').val();

    if (flag == true) {
        $("#basic-error").css('display', 'block');
        $("#basic-error").text("Please recheck the basic information");
        $("#basic-error").parent().parent().css('outline', 'none !important').attr("tabindex", -1).focus();
        return;
    }
    var product_specs = checkProperties();
    if (!product_specs[0]) {
        $("#specs-error").css('display', 'block');
        $("#specs-error").text("Required properties need to have atleast one value");
        console.log($("#specs-error").prev())
        $("#specs-error").prev().css('outline', 'none !important').attr("tabindex", -1).focus();
        return;

    }
    product_specs = product_specs[1];
    var url = window.location.href;
    var my_url = url.substring(url.indexOf("add_product"), url.length).trim();
    var category_name = my_url.substring(my_url.indexOf("/") + 1, my_url.length).trim();
    var product = {
        'category_name': category_name,
        'name': product_name,
        'price': product_price,
        'quantity': product_quantity,
        'brand': product_brand,
        //'photos' : photos_files,
        'property_values': product_specs
    }
    console.log(product);

    if (!is_edit) {
        addProduct(product);
    } else
        editProduct(product);


}

function addProduct(product) {
    console.log("Adding product" + product);
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    var url = window.location.href;
    var my_url = url.substring(url.indexOf("add_product"), url.length).trim();

    my_url = "/add_product";
    $.ajax({
        type: 'POST',
        url: my_url,
        data: product,
        success: function (data) {
            console.log("Success");
            console.log(data);
            var product_id = data.product.id;
            uploadImages(product_id);
        },
        error: function (data) {
            console.log("Error");
            console.log(data);

        }
    });

}

function editProduct(product) {
    console.log("Editing product" + product);

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    var url = window.location.href;
    var my_url = url.substring(url.indexOf("product"), url.length).trim();


    $.ajax({
        type: 'PUT',
        url: my_url,
        data: product,
        success: function (data) {


        },
        error: function (data) {

        }
    });

}

function uploadImages(id) {
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        }
    });

    var photos = this.getPhotosSrc();

    if (photos <= 0) return;

    var success = true;
    var count = 0;
    for (let i = 0; i < photos.length; i++) {
        var toUpload = new FormData();
        toUpload.append('id', id);
        var photo = photos[i];
        toUpload.append('photo',photo);

        $.ajax({
            type: 'POST',
            url: '/upload',
            data: toUpload,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log("Success");

            },
            error: function (data) {
                console.log("Error");
            }
        });        

    }
    if(photos.length == 0)
        return;
    /*if(success){

        var url = window.location.href;
        var index = url.indexOf('add_product');
        if(index != -1)
            url = url.substring(0,index);
        else{
            index = url.indexOf('/product');
            url = url.substring(0,index);
            url += '/';
        }
        document.location.href = url  + 'product/' + id;
    }*/

        



}

function checkProperties() {
    var correct = true;
    var property_header = $('.spec-header');
    var property_values = $('.spec-input');
    //console.log(property_header[1].innerText,property_values);
    var is_required = false;
    var prop_values = [];
    for (let i = 0; i < property_header.length; i++) {
        is_required = property_header[i].innerText.trim().endsWith('*');
        var result = checkPropertyValue(property_values[i].children, is_required)
        correct = result[1];
        var values = result[0];
        if (values != null && values.length != 0) {
            var property_name;
            if (is_required) {
                var index = property_header[i].innerText.lastIndexOf('*');
                property_name = $(".propertyName")[i].innerText.substring(0, index).trim();
            } else {
                property_name = $(".propertyName")[i].innerText.trim()
            }
            prop_values.push({ property: property_name, values: values });
        }

    }

    console.log(prop_values);

    return [correct, prop_values];

}


function checkPropertyValue(property_values, is_required) {
    var is_empty = true;
    var values = [];
    for (let i = 0; i < property_values.length; i++) {
        //console.log(property_values[i].value);
        if (property_values[i].value != '') {
            is_empty = false;
            values.push(property_values[i].value);
        }
    }
    if (is_empty && is_required) {

        property_values[0].style = "border: 2px solid #ff5555;"
        //property_values[0].focus();
        return [null, false];
    }

    return [values, true];
}

$(document).ready(function () {

    var addPhoto = $('#addPhoto');

    addPhoto.bind("click", addPhotoCard);


    var addEntry = $('input[name=addEntry');

    $('input[name=addEntry').each(function (item) {
        $(this).on("click", addEntryInput);
    });

    $('.imageUpload').on('change', function () {
        console.log("entrou");
        readUrl(this);
    });

    $('.saveProduct-btn').on("click", saveProduct);

   
       

})