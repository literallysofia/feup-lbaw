<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  /**
   * The product this review belongs to.
   */
  public function product() {
    return $this->belongsTo('App\Product');
  }

  public function user() {
    return $this->belongsTo('App\User');
  }
}
?>