<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Category_Property extends Model{
    public $timestamps = false;
    protected $table = 'category_properties';

    public function categories(){
        return $this->hasMany('App\Category');
    }

    public function properties(){
        return $this->hasMany('App\Property');
    }
}



?>