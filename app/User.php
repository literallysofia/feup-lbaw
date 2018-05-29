<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\DB;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable {
    use Notifiable;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'username','password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    public function isAdmin(){
        $admin = DB::table('admins')
                 ->where('user_id', '=', $this->id)
                 ->first();


        //$admin = DB::select ('select * from admin where user_id = :id', ['id'=> $this->id]);
        

        if(empty($admin))
            return false;
        else return true;
    }


    public function purchases() {
        return $this->hasMany('App\Purchase');
    }

    public function addresses() {
        return $this->hasMany('App\Address');
    }

    public function wishlist() {
        return $this->belongsToMany('App\Product', 'wishlists');
    }

    public function cart(){
        return $this->belongsToMany('App\Product', 'product_carts')
                    ->withPivot('quantity');
    }

    public function reviews(){
        return $this->hasMany('App\Review');
    }
}
