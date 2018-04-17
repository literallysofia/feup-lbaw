<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  public function user() {
    return $this->belongsTo('App\User', 'purchase_id');
  }

  public function purchase_product() {
    return $this->hasMany('App\Purchase_Product', 'user_id');
  }
}
