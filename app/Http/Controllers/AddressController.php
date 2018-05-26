<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use Illuminate\Support\Facades\Validator;

use App\User;
use App\Address;
use App\City;


class AddressController extends Controller{

    /**
     * Get a validator for an incoming address request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    public function validator(array $data) {

        return Validator::make($data, [
            'addressName' => 'required|string|max:30',
            'street' => 'required|string|max:255',
            'postalCode' => 'required|regex:/[0-9]{4}-[0-9]{3}/u',
            'countryId' => 'required|exists:countries,id',
            'cityId' => 'required|exists:cities,id'
        ]);

    }

    public function addAddressResponse(Request $request){
        
        $validator = $this->validator($request->all());
        if($validator->fails()) {
            return response()->json("Bad request", 400);
        }
        $addAddress = new Address;
        $addAddress->name = $request->addressName;
        $addAddress->street = $request->street;
        $addAddress->postal_code = $request->postalCode;
        $addAddress->city_id = $request->cityId;
        $addAddress->user_id = Auth::id();
        try {
            $addAddress->save();
        }catch(\Exception $e) {
            echo $e->getMessage();
        }


        if($addAddress){
            try {
                $newAddress = DB::table('addresses')->select('id','name','postal_code','street')->where('user_id',Auth::id())->orderBy('id','desc')->first();
        
            }catch(\Exception $e) {
                $e->getMessage();
            }
        }

        return response()->json(array('address'=> $newAddress), 200);
    }

    public function deleteAddressResponse(Request $request){
        
        Auth::check();
        $address = Address::findOrFail($request->addressId);

         $address->is_archived = true;
        try {
         $address->save();
        }catch(\Exception $e) {
            $e->getMessage();
        }
        
    }

}



?>