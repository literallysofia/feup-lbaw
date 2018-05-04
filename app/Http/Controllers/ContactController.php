<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class ContactController extends Controller{

    public function validator(array $data){
        return Validator::make($data,[
                'name' => 'required',
                'email'=> 'required|email',
                'subject' => 'required',
                'message' => 'required|string',

        ]);
    }


    public function sendEmail(Request $request){
        
        $validator = $this->validator($request->all());
        if($validator->fails()){
            return back()->with('error','There was a problem processing request.');
        }
        $data = array(
            'name' => $request->get('name'),
            'email' => $request->get('email'),
            'subject' => $request->get('subject'),
            'user_message' => $request->get('message')
        );

       
        Mail::send('emails.contact',$data,function($message) use ($data){
            $message->from('sweventechshop@gmail.com');
            $message->to('sweventechshop@gmail.com')->subject($data['subject']);
        });
        
        return back()->with('success','Thanks for contacting us, your request will be processed as fast as possible!');
        
    }
}




?>