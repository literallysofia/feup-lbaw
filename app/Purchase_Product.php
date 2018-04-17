<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Purchase_Product extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'product_purchases';

  public function purchase() {
    return $this->belongsTo('App\Purchase', 'purchase_id');
  }
}
