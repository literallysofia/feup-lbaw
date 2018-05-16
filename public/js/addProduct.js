
function addPreviewListener(list){
    if(list.children.length == 0 || list.children == null){
        return
    }

    var images = [];
   
    for(var i = 0; i<list.children.length-1;i++){
        let imagePreview = list.children[i].firstChild.firstChild;
        let imageInput = list.children[i].firstChild.lastChild.firstChild.firstChild;
        images.push({'imagePreview':imagePreview,'imageInput':imageInput});
    }

    console.log(images);
    images.forEach(function(item){
        item.imageInput.addEventListener('change',function(){
            readUrl(item.imagePreview,item.imageInput);
        },false);
    });
   
}

function addPhotoCard(e){
    var list = $('.photo-cards')[0];
    list.children[list.children.length-1].remove();
    var newCard = '<div class="mt-4 col-md-6 col-lg-3">' +
    '<div class="box d-flex flex-column ">' +
        '<div class="box d-flex flex-column align-items-center pt-0 pr-0 pl-0">' +
            '<img src="" alt="Photo preview" class="img-fluid" id="imagePreview">' +
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

    list.children[list.children.length-1].addEventListener("click",addPhotoCard);

    var theFreshCard = list.children[list.children.length-2];

    var imageInput = theFreshCard.firstChild.lastChild.firstChild.firstChild;
    
    

    var imagePreview = theFreshCard.firstChild.firstChild.firstChild;

    /*console.log(imagePreview);
    console.log(imageInput);*/

    list = $('.photo-cards')[0];
    addPreviewListener(list);

    /*imageInput.addEventListener('change',function(){
        readUrl(imagePreview,this);
    },false);*/
   


}

function readUrl(imagePreview,input){
    console.log("Added event ");
    
    if(input.files && input.files[0]){
        var reader = new FileReader();

        reader.onloadstart = function(e) {
        
          imagePreview.src =  e.target.result;
        }
    
        reader.readAsDataURL(input.files[0]);
        console.log(imagePreview.src);
    }
}

function addEntryInput(event){
    var input = document.createElement("INPUT");
    input.setAttribute("type","text");
    input.setAttribute("class","mb-2");
    event.target.offsetParent.firstElementChild.children[1].appendChild(input);
}


function addProduct(event){
    console.log(event);
    event.preventDefault();
    var flag = false;
    if($('#product_name').is(":invalid")){
        $('#product_name').css('border',"2px solid #ff5555");
        $('#product_name').focus();
        flag = true;
    }

    

    if($('#add_product_price').is(":invalid")){
        $('#add_product_price').css('border',"2px solid #ff5555");
        $('#add_product_price').focus();
        flag = true;
    }

    

    if($('#product_quantity').is(":invalid")){
        $('#product_quantity').css('border',"2px solid #ff5555");
        $('#product_quantity').focus();
        flag = true;
    }

    

    if($('#product_brand').is(":invalid")){
        $('#product_brand').css('border',"2px solid #ff5555");
        $('#product_brand').focus();
        flag = true;
    }

    var product_name = $('#product_name').value;
    var product_price = $('#add_product_price').value;
    var product_quantity = $('#product_quantity').value;
    var product_brand = $('#product_brand').value;

    if(flag = true) return;

    if(!checkProperties()) return;
    
}

function checkProperties(){

}

$(document).ready(function(){

    var addPhoto = $('#addPhoto');
    
    addPhoto.bind("click",addPhotoCard);


    var addEntry = $('input[name=addEntry');

    $('input[name=addEntry').each(function(item){
        $(this).bind("click",addEntryInput);
    });


    $('#addProductButton').bind("click",addProduct);
       
    


    
    


})