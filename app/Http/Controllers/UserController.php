<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\Middleware\Authenticate;

use App\User;

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
      $user = User::find($id);

      $this->authorize('show', $user);

      return view('pages.profile', ['user' => $user]);
    }

    public function __construct() 
    {
        $this->middleware('auth');
    }
}