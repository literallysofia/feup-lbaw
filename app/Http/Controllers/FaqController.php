<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;


class FaqController extends Controller{

    public function showFaqs(){

        try {
            $faqs = DB::table('faqs')->get();
        }catch(\Exception $e) {
            $e->getMessage();
            redirect('erros/404');
        }
        return view('pages.faq',['faqs'=>$faqs]);
    }

}

?>