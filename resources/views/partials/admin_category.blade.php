@foreach($categories as $category)
    <div class="mt-4 col-md-6 col-lg-4">
        <div id="category-{{$category->id}}" class="box d-flex flex-column ">
            <div class="category-header">
                <h6>{{$category->name}}</h6>
                <div class="d-flex flex-row">
                    <div class="checkbox-container form-check d-flex">
                        <label class="form-check-label">Show on the navigation menu
                            @if ($category->is_navbar_category)
                                <input type="checkbox" class="form-check-input" checked>
                            @else 
                                <input type="checkbox" class="form-check-input">
                            @endif
                            <span class="checkmark"></span>
                        </label>
                    </div>
                    <i class="fas fa-trash-alt ml-auto btn-deleteCategory"></i> 
                </div>
            </div>
            
            
            @foreach($category->properties as $catProperty)
            <div class="select-checkbox">
                <select>
                    @foreach($properties as $property)
                        @if ($property->name == $catProperty->name)
                            <option selected value="property-{{$property->id}}">{{$property->name}}</option>
                        @else 
                            <option value="property-{{$property->id}}">{{$property->name}}</option>
                        @endif
                    @endforeach
                    <option value="" style="font-style:italic;" >None</option>
                </select>

                <div class="checkbox-container form-check d-flex">
                    <label class="form-check-label">Required Property
                     
                        @if ($catProperty->category_properties->where('category_id', $category->id)->first()->is_required_property == 1)
                            <input type="checkbox" class="form-check-input" checked>
                        @else 
                            <input type="checkbox" class="form-check-input">
                        @endif
                       
                        <span class="checkmark"></span>
                    </label>
                </div>
            </div>
            @endforeach


            <div class="select-checkbox default" style="visibility: hidden;">
                <select>
                    <option value="" disabled selected> Select property</option>
                    @foreach($properties as $property)
                        <option value="property-{{$property->id}}">{{$property->name}}</option>
                    @endforeach
                    <option value="" style="font-style:italic;" >None</option>
                </select>

                <div class="checkbox-container form-check d-flex">
                    <label class="form-check-label">Required Property
                        <input type="checkbox" class="form-check-input">
                        <span class="checkmark"></span>
                    </label>
                </div>
            </div>

            <div class="entry-buttons">
                <input class="btn-addEntryCategory" type="button" value="Add Entry">
                <input class="btn-addProductCategory" type="button" value="Add Product" onclick="window.location='{{  route("add_product",["category_name" => $category->name])}}'">
                <input class="btn-saveCategory black-button" type="button" value="Save">
            </div>
        </div>
    </div>
@endforeach
