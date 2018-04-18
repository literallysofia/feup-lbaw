<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class City extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'cities';

  public function addresses() {
    return $this->hasMany('App\Address', 'city_id', 'id');
  }

  public function country() {
    return $this->belongsTo('App\Country', 'id');
  }
}