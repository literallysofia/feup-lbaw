<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Value extends Model{
    public $timestamps = false;
    protected $table = 'values';

    public function values_list(){
        return $this->belongsTo('App\ValuesLists');
    }
}

?>