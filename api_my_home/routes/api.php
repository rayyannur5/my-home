<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\DeviceController;
use App\Http\Controllers\API\RoomController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::middleware('auth:api')->group(function () {
    Route::get('user', [AuthController::class, 'index']);
    Route::put('user', [AuthController::class, 'update']);
    Route::post('password', [AuthController::class, 'checkPassword']);
    Route::get('logout', [AuthController::class, 'logout']);
    Route::resource('rooms', RoomController::class);
    Route::get('rooms/{id}/devices', [RoomController::class, 'getDevices']);
    Route::resource('devices', DeviceController::class);
});