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
      $user = User::findOrFail($id);

      $this->authorize('show', $user);
      try {
        $purchases = $user->purchases()->get();
        $addresses = $user->addresses()->where('is_archived',false)->get();
        $countries = Country::get();
        $cities = City::get();
      }catch(\Exception $e) {
        $e->getMessage();
        return response()->setStatusCode(400);

      }

      return view('pages.profile', ['user' => $user, 'addresses' => $addresses, 'purchases'=>$purchases, 'countries'=>$countries, 'cities'=>$cities]);

    }

    public function editProfile(Request $request) {
        Auth::check();
        if($request->old_password != null) {
           if(Hash::check($request->old_password, Auth::user()->password)) {
                $password = Hash::make($request->new_password);
                Auth::user()->password = $password;
                try {
                    Auth::user()->save();
                }catch(\Exception $e) {
                    $e->getMessage();
                    return response(json_encode("Error updating password"), 400);  
                }
            } else return response(json_encode("Old password is incorrect"), 400);
        }
        if($request->name != null) {
            Auth::user()->name = $request->name;
            try {
                Auth::user()->save();
            }catch(\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating name"), 400);
            }
        }
        if($request->username != null) {
            Auth::user()->username = $request->username;
            try {
                Auth::user()->save();
            }catch(\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating username"), 400);  
            }
        }
        if($request->email != null) {
            Auth::user()->email = $request->email;
            try {
                Auth::user()->save();
            }catch(\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating email"), 400);  
            }
        }
        return response(json_encode("User updated with success"), 200);
    }

    public function __construct() {
        $this->middleware('auth');
    }
}