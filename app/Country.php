<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;

  public function cities() {
    return $this->hasMany('App\City', 'country_id');
  }

}