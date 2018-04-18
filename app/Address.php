<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
  // Don't add create and update timestamps in database.
  public $timestamps  = false;
  protected $table = 'addresses';

  public function city() {
    return $this->belongsTo('App\City', 'id');
  }

  public function user() {
    return $this->belongsTo('App\User', 'id');
  }

  public function purchases() {
    return $this->hasMany('App\Purchase', 'address_id', 'id');
  }

}