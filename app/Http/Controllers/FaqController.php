<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;
use App\Http\Controllers\Controller;

use App\Faq;

class FaqController extends Controller{

    public function showFaqs(){

        try {
            $faqs = Faq::get();
        }catch(\Exception $e) {
            $e->getMessage();
            redirect('erros/404');
        }
        return view('pages.faq',['faqs'=>$faqs]);
    }

}

?>