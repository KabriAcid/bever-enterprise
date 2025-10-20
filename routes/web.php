<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Client\InitializeController;
use App\Http\Controllers\Admin\InitializeController as AdminInitializeController;


// Client routes
Route::get('/', fn() => view('client.index'))->name('client.index');
Route::get('/dashboard', fn() => view('client.dashboard'))->name('client.dashboard');
Route::get('/cart', fn() => view('client.cart'))->name('client.cart');
Route::get('/cart-new-ui', fn() => view('client.cart-new-ui'))->name('client.cart-new-ui');
Route::get('/checkout', fn() => view('client.checkout'))->name('client.checkout');
Route::get('/logout', fn() => view('client.logout'))->name('client.logout');
Route::get('/notifications', fn() => view('client.notifications'))->name('client.notifications');
Route::get('/orders', fn() => view('client.orders'))->name('client.orders');
Route::get('/view-product', fn() => view('client.product'))->name('client.product');
Route::get('/products', fn() => view('client.products'))->name('client.products');
Route::get('/profile', fn() => view('client.profile'))->name('client.profile');
Route::get('/register', fn() => view('client.register'))->name('client.register');
Route::get('/settings', fn() => view('client.settings'))->name('client.settings');
Route::get('/test', fn() => view('client.test'))->name('client.test');
Route::get('/initialize', InitializeController::class)->name('client.initialize');

// Admin routes
Route::get('/admin/initialize', AdminInitializeController::class)->name('admin.initialize');

