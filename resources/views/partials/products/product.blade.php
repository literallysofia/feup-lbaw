@foreach($products as $product)
<div class="mt-4 col-md-12 col-lg-4">
    <div class="box d-flex flex-column align-items-center">
        <a href="{{ route('product', ['product_id'=> $product->id]) }}">
            <img src="{{ $product->photos->first()->path }}" alt="{{ $product->name }}" class="img-fluid" style="cursor:pointer;"></a>
        <a href="{{ route('product', ['product_id'=> $product->id]) }}">
            <h6 style="cursor:pointer;">{{ $product->name }}</h6></a>
        <span>{{ $product->price }} €</span>
        <input type="button" value="Add To Cart" onclick="return addToCart(null, {{$product->id}})">
    </div>
</div>
@endforeach