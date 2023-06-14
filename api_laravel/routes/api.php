<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

// Route::post('/login',[AuthController::class,'login']);
// Route::get('/logout',[AuthController::class,'logout'])->middleware(['auth:sanctum']);
// Route::post('/register',[AuthController::class,'register']);

// Route::prefix('/products')->group(function () {
//     Route::get('/',[ProductController::class,'index'])->middleware(['auth:sanctum']);
//     Route::get('/{id}',[ProductController::class,'show'])->middleware(['auth:sanctum']);
//     Route::post('/',[ProductController::class,'store'])->middleware(['auth:sanctum']);
//     Route::post('/{id}',[ProductController::class,'update'])->middleware(['auth:sanctum']);
//     Route::delete('/{id}',[ProductController::class,'destroy'])->middleware(['auth:sanctum']);
// });

// Route::prefix('/categories')->group(function () {
//     Route::get('/',[CategoryController::class,'index'])->middleware(['auth:sanctum']);
//     Route::get('/{id}',[CategoryController::class,'show'])->middleware(['auth:sanctum']);
//     Route::post('/',[CategoryController::class,'store'])->middleware(['auth:sanctum']);
//     Route::post('/{id}',[CategoryController::class,'update'])->middleware(['auth:sanctum']);
//     Route::delete('/{id}',[CategoryController::class,'destroy'])->middleware(['auth:sanctum']);
// });



Route::prefix('/products')->group(function () {
    Route::get('/',[ProductController::class,'index']);
    Route::get('/{id}',[ProductController::class,'show']);
    Route::post('/',[ProductController::class,'store']);
    Route::post('/{id}',[ProductController::class,'update']);
    Route::delete('/{id}',[ProductController::class,'destroy']);
    Route::get('/images/{fileName}', [ProductController::class,'showImages']);
});

Route::prefix('/categories')->group(function () {
    Route::get('/',[CategoryController::class,'index']);
    Route::get('/{id}',[CategoryController::class,'show']);
    Route::post('/',[CategoryController::class,'store']);
    Route::post('/{id}',[CategoryController::class,'update']);
    Route::delete('/{id}',[CategoryController::class,'destroy']);
});