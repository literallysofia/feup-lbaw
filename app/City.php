<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class City extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  public function country() {
    return $this->belongsTo('App\Country', 'id');
  }
}