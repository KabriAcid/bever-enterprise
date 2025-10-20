<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\Admin;

class InitializeController extends Controller
{
    public function __invoke()
    {
        // Assuming you have a separate guard for admin, e.g. 'admin'
        if (!Auth::guard('admin')->check()) {
            return redirect()->route('admin.index');
        }

        $admin = Auth::guard('admin')->user();
        return view('admin.initialize', compact('admin'));
    }
}
