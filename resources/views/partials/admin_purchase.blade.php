<tr class="unbold">
    <td data-toggle="collapse" data-target='#admin_purchase-{{$purchase->id}}' class="clickable" onclick="boldUnboldText(this)">{{$purchase->user->username}}</td>
    <td data-toggle="collapse" data-target='#admin_purchase-{{$purchase->id}}' class="clickable" onclick="boldUnboldText(this)">{{date('d/m/Y', strtotime($purchase->date))}}</td>
    <td>

        @if ($purchase->status == 'Processing')
        <select class="select-status">
            <option value="Processing" selected>Processing</option>
            <option value="Shipped">Shipped</option>
            <option value="Delivered">Delivered</option>            
        </select>
        @elseif($purchase->status == 'Shipped')
        <select class="select-status">
            <option value="Processing"> Processing</option>        
            <option value="Shipped" selected>Shipped</option>
            <option value="Delivered">Delivered</option>
        </select>
        @elseif($purchase->status == 'Delivered')
        <select class="select-status">
            <option value="Processing"> Processing</option>        
            <option value="Shipped" >Shipped</option>
            <option value="Delivered" selected>Delivered</option>
        </select>
        @endif

    </td>
    <td data-toggle="collapse" data-target='#admin_purchase-{{$purchase->id}}' class="clickable" onclick="boldUnboldText(this)">{{$purchase->total}}€</td>
</tr>
<tr>
    <td colspan="4" class="collapse-line">
        <div id= 'admin_purchase-{{$purchase->id}}' class="collapse-div collapse">
        <p class="accordion_list_title">Products</p>
        @each('partials.purchase_product', $purchase->products,'purchase_product')
        <p class="accordion_list_title mt-3">Delivery Type</p>
        <div class="container">
            <div class="row">
                <p class="col-lg-auto col-md-auto col-sm-auto">{{$purchase->deliverytype->name}}</p>
                <hr class="col">
                <p class="col-lg-auto col-md-auto col-sm-auto">{{$purchase->deliverytype->price}}€</p>
            </div>
        </div>        
        <p class="accordion_list_title mt-3">Address</p>
        <p>{{$purchase->address->street}},
            {{$purchase->address->postal_code}},
            {{$purchase->address->city->name}}, 
            {{$purchase->address->city->country->name}} </p>
        </div>
    </td>
</tr>