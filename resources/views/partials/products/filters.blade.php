@php
if ($price_limit === NULL) {
    $value = $price_max;
} else {
    $value = $price_limit;
}
@endphp
<div class="filters d-flex flex-column">
    <h5>Filters</h5>
    @if (count($available_brands) >= 1)
        <h6>Brand</h6>
        @foreach($available_brands as $brand)
        <div class="form-check">
            <label class="form-check-label">
            @if(!empty($brands) && in_array($brand, $brands))
                <input class="form-check-input" type="checkbox" name="brands[]" value="{{ $brand }}" checked>
            @else
                <input class="form-check-input" type="checkbox" name="brands[]" value="{{ $brand }}">
            @endif
                <p>{{ $brand }}</p>
            </label>
        </div>
        @endforeach
    @endif
    <h6>Max Price</h6>
    <div class="price-slider">
        <input class="price-slider-range" type="range" value="{{ $value }}" min="0" max="{{ $price_max }}">
        <span class="price-slider-value"></span>
    </div>
    <a href="{{ route('category_products', ['category_id' => $category->id, 'sort' => $sort]) }}">Apply</a>
</div>