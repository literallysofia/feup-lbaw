@php
if ($price_limit === NULL) {
    $price = $price_max;
} else {
    $price = $price_limit;
}
$brand_arr = explode( ',', $brands);
@endphp
<div class="filters d-flex flex-column">
    <h5>Filters</h5>
    @if (count($brands_filter) >= 1)
        <h6>Brand</h6>
        @foreach($brands_filter as $brand)
        <div class="form-check">
            <label class="form-check-label">
            @if(!empty($brand_arr) && in_array($brand, $brand_arr))
                <input class="form-check-input" type="checkbox" name="brands[]" value="{{ $brand }}" checked>
            @else
                <input class="form-check-input" type="checkbox" name="brands[]" value="{{ $brand }}">
            @endif
                {{ $brand }}
            </label>
        </div>
        @endforeach
    @endif
    @if (count($properties_filter) >= 1)
        @foreach($properties_filter as $property => $values)
            <h6>{{ $property }}</h6>
            @foreach($values as $value)
            <div class="form-check">
                <label class="form-check-label">
                @if(!empty($properties) && array_key_exists($property, $properties))
                    <input class="form-check-input" type="checkbox" name="properties[]" value="{{ $property }};{{ $value }}" checked>
                @else
                    <input class="form-check-input" type="checkbox" name="properties[]" value="{{ $property }};{{ $value }}">
                @endif
                    {{ $value }}
                </label>
            </div>
            @endforeach
        @endforeach
    @endif
    <h6>Max Price</h6>
    <div class="price-slider">
        <input class="price-slider-range" type="range" value="{{ $price }}" min="0" max="{{ $price_max }}">
        <span class="price-slider-value"></span>
    </div>
    <a href="{{ route('category_products', ['category_id' => $category->id, 'sort' => $sort]) }}">Apply</a>
</div>
