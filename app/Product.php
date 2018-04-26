<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'products';

  public function purchase(){
    return $this->belongsToMany('App\Purchase')
        ->withPivot('quantity', 'price');
  }

  public function category(){
    return $this->belongsTo('App\Category');
  }
}