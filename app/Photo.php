<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Photo extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  /**
   * The card this item belongs to.
   */
  public function product() {
    return $this->belongsTo('App\Product');
  }
}
?>