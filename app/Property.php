<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Property extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'properties';

  public function categories(){
    return $this->belongsToMany('App\Category');
  }
  public function category_properties(){
    return $this->belongsToMany('App\Category_Property');
  }
}