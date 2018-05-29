@foreach($products as $product)
<div class="mt-4 col-md-12 col-lg-4">
    <div class="box d-flex flex-column align-items-center">
        <a href="{{route('product', ['product_id'=> $product->id])}}"><img src="{{$product->photos->get(0)->path}}" alt="Item 1" class="img-fluid" onclick="window.location='product.html'" style="cursor:pointer;"></a>
        <a href="{{route('product', ['product_id'=> $product->id])}}"><h6 onclick="window.location='product.html'" style="cursor:pointer;">{{$product->name}}</h6></a>
        <span>{{$product->price}} €</span>
        <input type="button" value="Add To Cart">
    </div>
</div>
@endforeach