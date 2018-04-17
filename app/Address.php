<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  public function city() {
    return $this->belongsTo('App\City', 'id');
  }

  public function user() {
    return $this->belongsTo('App\User', 'id');
  }

}