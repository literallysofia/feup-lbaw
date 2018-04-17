           <tr data-toggle="collapse" data-target=<?php echo '#purchase'; echo $purchase->id;?> class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>{{date('d/m/Y', strtotime($purchase->date))}}</td>
                <td>{{$purchase->status}}</td>
                <td>{{$purchase->total}}€</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id= <?php echo 'purchase'; echo $purchase->id;?> class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    @each('partials.purchase_product', $purchase->products()->get(),'purchase_product')
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>