           <tr data-toggle="collapse" data-target=<?php echo '#purchase'; echo $purchase->id;?> class="clickable unbold" onclick="boldUnboldLine(this)">
                <td>{{$purchase->date}}</td>
                <td>{{$purchase->status}}</td>
                <td>{{$purchase->total}}</td>
              </tr>
              <tr>
                <td colspan="3" class="collapse-line">
                  <div id= <?php echo 'purchase'; echo $purchase->id;?> class="collapse-div collapse">
                    <p class="accordion_list_title">Products</p>
                    <!--<div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple iPhone X - 256GB Silver</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1359,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Samsung Galaxy S8 - G950FZ - Midnight Black</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">819,99€</p>
                      </div>
                    </div>
                    <div class="product_list container">
                      <div class="row" onclick="window.location='product.html'">
                        <p class="col-lg-auto col-md-auto col-sm-auto">Apple MacBook Pro 13'' Retina i5-2,3GHz</p>
                        <hr class="col">
                        <p class="col-lg-auto col-md-auto col-sm-auto">1549€</p>
                      </div>
                    </div>-->
                    <p class="accordion_list_title mt-3">Address</p>
                    <p> R. Dr. Roberto Frias, 4200-465 Porto, Portugal </p>
                  </div>
                </td>
              </tr>