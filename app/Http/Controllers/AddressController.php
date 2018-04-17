<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;

class AddressController extends Controller{

    public function addAddressResponse(Request $request){
        
        $city = DB::table('cities')->select('id','country_id')->where('name',$request->city)->get()[0];
        $cityId = $city->id;

        $countryName = DB::table('countries')->select('name')->where('id',$city->country_id)->get()[0]->name;
        $addAddress = DB::table('addresses')->insert(
            ['name' => $request->addressName,'street' => $request->street,
            'postal_code' => $request->postalCode,
            'city_id' => $cityId,
            'user_id' => $request->userId]
        );

        if($addAddress){
            $newAddress = DB::table('addresses')->select('id','name','postal_code','street')->orderBy('id','desc')->first();
            $newAddress->city_name = $request->city;
            $newAddress->country_name = $countryName;
        }

        

        return response()->json(array('address'=> $newAddress), 200);
    }

    public function deleteAddressResponse(Request $request){
        $removedAddress = DB::table('addresses')->where('id',$request->id)->update(['is_archived' => true]);
        return response()->json(array('deleted' => $removedAddress),200);
    }

}



?>