<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;
use App\Address;
use App\City;


class AddressController extends Controller{

    public function addAddressResponse(Request $request){
        
        $addAddress = new Address;
        $addAddress->name = $request->addressName;
        $addAddress->street = $request->street;
        $addAddress->postal_code = $request->postalCode;
        $addAddress->city_id = $request->cityId;
        $addAddress->user_id = Auth::id();
        $addAddress->save();
        /*$city = City::find($request->cityId);
        $city->addresses()->attach($addAddress);
        Auth::user()->addresses()->attach($addAddress);
        $city->save();
        Auth::user()->save();*/
        return response()->json(array('address'=> $addAddress), 200);
        
        //
        //$addAddress->user()->associate(Auth::user());
        //$addAddress->city()->save($city);
        //$addAddress->user()->save(Auth::user());
        //$addAddress->save();

        /*$addAddress->city_id = $request->cityId;
        $addAddress->user_id = Auth::id();
        $addAddress->city()->associate($city);
        $addAddress->user()->associate();
        $addAddress->create();*/

        /*$addAddress = DB::table('addresses')->insert(
            ['name' => $request->addressName,'street' => $request->street,
            'postal_code' => $request->postalCode,
            'city_id' => $request->cityId,
            'user_id' => Auth::id()]
        );*/

        /*if($addAddress){
            $newAddress = DB::table('addresses')->select('id','name','postal_code','street')->orderBy('id','desc')->first();
            $newAddress->city_name = $request->city;
            $newAddress->country_name = $countryName;
        }*/

        

        return response()->json(array('address'=> $request), 200);
    }

    public function deleteAddressResponse(Request $request){

         Auth::check();
         $address = Address::find($request->addressId);

         $address->is_archived = true;

         $address->save();
        
    }

}



?>