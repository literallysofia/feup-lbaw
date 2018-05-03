<tr class="unbold">
    <td data-toggle="collapse" data-target=<?php echo '#admin-purchase-'; echo $purchase->id;?> class="clickable" onclick="boldUnboldText(this)">{{$purchase->user->username}}</td>
    <td data-toggle="collapse" data-target=<?php echo '#admin-purchase-'; echo $purchase->id;?> class="clickable" onclick="boldUnboldText(this)">{{date('d/m/Y', strtotime($purchase->date))}}</td>
    <td>

          @if ($purchase->status == 'Processing')
            <select class="select-status">
                <option value="1" selected="selected">Processing</option>
                <option value="2">Shipped</option>
            </select>
          @elseif($purchase->status == 'Shipped')
            <select class="select-status">
                <option value="1" selected="selected">Shipped</option>
                <option value="2">Delivered</option>
            </select>
          @endif
    </td>
    <td data-toggle="collapse" data-target=<?php echo '#admin-purchase-'; echo $purchase->id;?> class="clickable" onclick="boldUnboldText(this)">{{$purchase->total}}€</td>
</tr>
<tr>
    <td colspan="4" class="collapse-line">
        <div id= <?php echo 'admin-purchase-'; echo $purchase->id;?> class="collapse-div collapse">
        <p class="accordion_list_title">Products</p>
        @each('partials.purchase_product', $purchase->products,'purchase_product')        
        <p class="accordion_list_title mt-3">Address</p>
        <p>{{$purchase->address->street}},
            {{$purchase->address->postal_code}},
            {{$purchase->address->city->name}}, 
            {{$purchase->address->city->country->name}} </p>
        </div>
    </td>
</tr>