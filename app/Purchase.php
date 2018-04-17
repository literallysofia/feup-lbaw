<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'purchases';

  public function user() {
    return $this->belongsTo('App\User', 'id');
  }

  /*public function purchase_products() {
    return $this->hasMany('App\Purchase_Product', 'purchase_id');
  }*/

  public function products(){
      return $this->belongsToMany('App\Product')
        ->withPivot('quantity', 'price');
  }
}
