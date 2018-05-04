<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'categories';

  public function products(){
    return $this->hasMany('App\Product');
  }

  public function properties(){
    return $this->belongsToMany('App\Property');
  }

  public function category_properties(){
    return $this->belongsToMany('App\Category_Property');
  }
}