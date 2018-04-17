<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;
use App\Country;
use App\City;

class UserController extends Controller
{
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function showProfile($id)
    {
      $user = User::find($id);

      $this->authorize('show', $user);

      $addresses = DB::select(
        DB::raw('SELECT A.id AS id, A.name AS name, A.street AS street, A."postal_code" AS postal_code, CTY.name AS city, CNTR.name AS country
                    FROM addresses AS A, cities AS CTY,countries AS CNTR 
                    WHERE A."user_id" = :id 
                    AND A."city_id" = CTY.id 
                    AND CTY."country_id" = CNTR.id 
                    AND A.is_archived = false'), 
        array( 'id'=> $id)
        );

      $purchases = $user->purchases()->get();

      $countries = Country::get();
      $cities = City::get();

      return view('pages.profile', ['user' => $user, 'addresses' => $addresses, 'purchases'=>$purchases, 'countries'=>$countries, 'cities'=>$cities]);

    }

    public function __construct() 
    {
        $this->middleware('auth');
    }
}