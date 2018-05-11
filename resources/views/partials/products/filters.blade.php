@php
if ($price_limit === NULL) {
    $value = 0;
} else {
    $value = $price_limit;
}
@endphp
<div class="filters d-flex flex-column">
    <h5>Filters</h5>
    @if (count($brands) >= 1)
        <h6>Brand</h6>
        @foreach($brands as $brand)
        <div class="form-check">
            <label class="form-check-label">
                <input type="checkbox" class="form-check-input">
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