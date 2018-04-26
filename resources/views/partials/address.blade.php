<div class="mt-4 col-md-6 col-lg-3">
    <div id=<?php echo 'address-'; echo $address->id;?> class="box d-flex flex-column">
        <div class="d-flex flex-row address-header">
            <h6>{{$address->name}}</h6>
            <i class="fas fa-trash-alt ml-auto btn-deleteAddress"></i>
        </div>
        <h6>{{$address->street}}, {{$address->postal_code}}, {{$address->city->name}}, {{$address->city->country->name}}</h6>
    </div>
</div>