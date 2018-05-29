
@foreach($properties as $property)
<div class="mt-4 col-md-6 col-lg-4">
    <div class="box d-flex flex-column ">
        <div class="spec-header">
           
            <h6>{{$property->name}}
            @if($property->category_properties->where('category_id',$category->id)->first()->is_required_property) 
            *
            @endif</h6>
        </div>
        <div class="spec-input">
            @if($product != null && count($product->category_properties->where('property_id',$property->id)) >0 ) 
               @php $aux = $product->category_properties->where('property_id',$property->id)->first();
                    $property_values = $aux->values_lists->where('product_id', $product->id)->first()->values; @endphp 
               
            @else
                @php $property_values = null; @endphp   
            @endif
                @if($property_values != null && count($property_values) > 0)
                    @foreach($property_values as $value)
                        <input class="mb-2" type="text" value="{{$value->name}}"></input>
                    @endforeach
                @else 
                    <input class="mb-2" type="text" ></input>
                    <input class="mb-2" type="text"></input>
                @endif
        </div>
        <div class="entry-buttons">
            <input type="button" value="Add Entry" name="addEntry"></input>
        </div>
    </div>
</div>
@endforeach