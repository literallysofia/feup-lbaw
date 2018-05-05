<?php

namespace App;
use Illuminate\Database\Eloquent\Relations\Pivot;


class CategoryProperty extends Pivot{
    public $timestamps = false;
    protected $table = 'category_properties';

    public function products(){
        return $this->belongsToMany('App\Product', 'values_lists', 'category_property_id', 'product_id')
                ->using('App\ValuesLists');
    }

    public function values_lists() {
        return $this->hasMany('App\ValuesLists', 'category_property_id', 'id');
    }

    public function property() {
        return $this->belongsTo('App\Property');
    }

    public function category() {
        return $this->belongsTo('App\Category');
    }

    public function getCreatedAtColumn()
    {
        if ($this->pivotParent) {
            return $this->pivotParent->getCreatedAtColumn();
        }

        return static::CREATED_AT;
    }


}

?>