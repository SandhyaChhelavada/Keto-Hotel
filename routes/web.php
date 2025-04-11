<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminController;



Route::get('/', [AdminController::class, 'home'])->name('home');
Route::get('/home', [AdminController::class, 'index'])->name('dashboard');
Route::get('/create_room', [AdminController::class, 'create_room']);



