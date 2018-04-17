<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;
use App\Country;
use App\City;

class UserController extends Controller {
    /**
     * Shows the user for a given id.
     *
     * @param  int  $id
     * @return Response
     */
    public function showProfile($id) {
      $user = User::find($id);

      $this->authorize('show', $user);
      $purchases = $user->purchases()->get();
      $addresses = $user->addresses()->where('is_archived',false)->get();

      $countries = Country::get();
      $cities = City::get();

      return view('pages.profile', ['user' => $user, 'addresses' => $addresses, 'purchases'=>$purchases, 'countries'=>$countries, 'cities'=>$cities]);

    }

    public function editProfile(Request $request) {
        Auth::check();
        if($request->old_password != null) {
           if(Hash::check($request->old_password, Auth::user()->password)) {
                $password = Hash::make($request->new_password);
                Auth::user()->password = $password;
                Auth::user()->save();
            } else return false;
        }
        if($request->name != null) {
            Auth::user()->name = $request->name;
            Auth::user()->save();
        }
        if($request->username != null) {
            Auth::user()->username = $request->username;
            Auth::user()->save();
        }
        if($request->email != null) {
            Auth::user()->email = $request->email;
            Auth::user()->save();
        }
        //return response()->setStatusCods(200);
    }

    public function __construct() {
        $this->middleware('auth');
    }
}