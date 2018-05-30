<div class="mt-4 col-md-6 col-lg-3">
    <div class="box d-flex flex-column ">
        <div class="box d-flex flex-column align-items-center pt-0 pr-0 pl-0">
            <img src="{{asset($photo->path)}}" alt="Product Photo" class="img-fluid product_photo">
        </div>
        <div class="mt-auto">
            <div class="custom-file">
                <input type="file" class="imageUpload custom-file-input" id="imageUpload" accept=".png, .jpg, .jpeg" >
                <label class="custom-file-label" for="imageUpload">Choose file</label>
            </div>
        </div>
    </div>
</div>