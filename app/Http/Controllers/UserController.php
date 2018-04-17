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

      $purchases = $user->purchases()->get();
      $addresses = $user->addresses()->get();

      $countries = Country::get();
      $cities = City::get();

      return view('pages.profile', ['user' => $user, 'addresses' => $addresses, 'purchases'=>$purchases, 'countries'=>$countries, 'cities'=>$cities]);

    }

    public function __construct() 
    {
        $this->middleware('auth');
    }
}