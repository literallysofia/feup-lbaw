<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;
use App\Address;

class AddressController extends Controller{

    public function addAddressResponse(Request $request){
        
        
        $addAddress = DB::table('addresses')->insert(
            ['name' => $request->addressName,'street' => $request->street,
            'postal_code' => $request->postalCode,
            'city_id' => $request->cityId,
            'user_id' => Auth::id()]
        );

        if($addAddress){
            $newAddress = DB::table('addresses')->select('id','name','postal_code','street')->orderBy('id','desc')->first();
            $newAddress->city_name = $request->city;
            $newAddress->country_name = $countryName;
        }

        

        return response()->json(array('address'=> $newAddress), 200);
    }

    public function deleteAddressResponse(Request $request){

         Auth::check();
         $address = Address::find($request->addressId);

         $address->is_archived = true;

         $address->save();
        
    }

}



?>