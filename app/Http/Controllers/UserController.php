<?php

namespace App\Http\Controllers;

use App\City;
use App\Country;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

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
        $user = User::findOrFail($id);

        $this->authorize('show', $user);
        try {
            $shipped_purchases = $user->purchases()->where('status', 'Shipped')->orderBy('date')->get();
            $processing_purchases = $user->purchases()->where('status', 'Processing')->orderBy('date')->get();
            $delivered_purchases = $user->purchases()->where('status', 'Delivered')->orderBy('date')->get();

            $addresses = $user->addresses()->where('is_archived', false)->get();
            $countries = Country::get();
            $cities = City::get();
        } catch (\Exception $e) {
            return response(json_encode($e->getMessage()), 400);
        }

        return view('pages.profile', ['user' => $user, 'addresses' => $addresses,
            'shipped_purchases' => $shipped_purchases, 'processing_purchases' => $processing_purchases, 'delivered_purchases' => $delivered_purchases,
            'countries' => $countries, 'cities' => $cities]);

    }

    public function validator(array $data)
    {

        return Validator::make($data, [
            'name' => "sometimes|regex:/^[A-Z][a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/u|max:255",
            'username' => 'sometimes|regex:/^[a-zA-Z0-9]{6,20}$/u|unique:users',
            'email' => 'sometimes|string|email|max:255|unique:users',
            'old_password' => 'sometimes',
            'new_password' => 'sometimes|regex:/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/u',
        ]);

    }

    public function editProfile(Request $request)
    {
        Auth::check();

        $validator = $this->validator($request->all());
        if ($validator->fails()) {
            return response(json_encode("Error validating user data"), 400);
        }
        if ($request->old_password != null) {
            if (Hash::check($request->old_password, Auth::user()->password)) {
                $password = Hash::make($request->new_password);
                Auth::user()->password = $password;
                try {
                    Auth::user()->save();
                } catch (\Exception $e) {
                    $e->getMessage();
                    return response(json_encode("Error updating password"), 400);
                }
            } else {
                return response(json_encode("Old password is incorrect"), 400);
            }

        }
        if ($request->name != null) {
            Auth::user()->name = $request->name;
            try {
                Auth::user()->save();
            } catch (\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating name"), 400);
            }
        }
        if ($request->username != null) {
            Auth::user()->username = $request->username;
            try {
                Auth::user()->save();
            } catch (\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating username"), 400);
            }
        }
        if ($request->email != null) {
            Auth::user()->email = $request->email;
            try {
                Auth::user()->save();
            } catch (\Exception $e) {
                $e->getMessage();
                return response(json_encode("Error updating email"), 400);
            }
        }
        return response(json_encode("User updated with success"), 200);
    }

    public function __construct()
    {
        $this->middleware('auth');
    }

}
