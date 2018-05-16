<?php

namespace App;

use Illuminate\Database\Eloquent\Relations\Pivot;


class ValuesLists extends Pivot{
    public $timestamps = false;
    protected $table = 'values_lists';

    public function category_property() {
        return $this->belongsTo('App\CategoryProperty');
    }

    public function product() {
        return $this->belongsTo('App\Product');
    }

    public function values(){
        return $this->hasMany('App\Value', 'values_lists_id');
    }

}

?>