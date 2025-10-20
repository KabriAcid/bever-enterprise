<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class InitializeController extends Controller
{
    public function __invoke()
    {
        if (!Auth::check()) {
            return redirect()->route('client.index');
        }

        $user = Auth::user();
        return view('client.initialize', compact('user'));
    }
}
