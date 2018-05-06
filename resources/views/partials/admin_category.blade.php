@foreach($categories as $category)
    <div class="mt-4 col-md-6 col-lg-4">
        <div class="box d-flex flex-column">
            <div class="d-flex flex-row category-header">
                <h6>{{$category->name}}</h6>
                <i class="fas fa-trash-alt ml-auto"></i>
            </div>

            @foreach($category->properties as $catProperty)
            <div class="select-checkbox">
                <select>
                    {{--<option selected value>{{$catProperty->name}}</option>--}}
                    @foreach($properties as $property)
                        @if ($property->name == $catProperty->name)
                            <option selected value>{{$property->name}}</option>
                        @else 
                            <option value="{{$property->name}}">{{$property->name}}</option>
                        @endif
                    @endforeach
                    <option value="None" style="font-style:italic;" >None</option>
                </select>

                <div class="checkbox-container form-check d-flex">
                    <label class="form-check-label">Required Property
                        <input type="checkbox" class="form-check-input">
                        <span class="checkmark"></span>
                    </label>
                </div>
            </div>
            @endforeach

            <div class="entry-buttons">
            <input type="button" value="Add Entry"></input>
            <input type="button" value="Add Product" onclick="window.location='add_product.html'"></input>
            <input type="button" class="black-button" value="Save"></input>
            </div>
        </div>
    </div>
@endforeach
