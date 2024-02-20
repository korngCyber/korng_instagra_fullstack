<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\PostController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
//rount management
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:api');
Route::get('/user', [AuthController::class, 'user'])->middleware('auth:api');
Route::post('/update-profile', [AuthController::class, 'updateProfile'])->middleware('auth:api');
Route::delete('/delete-account', [AuthController::class, 'deleteAccount'])->middleware('auth:api');


//============== Post management route
Route::get('/post',[PostController::class,'index'])->middleware('auth:api');
Route::post('/post',[PostController::class,'store'])->middleware('auth:api');
Route::post('/post/{id}',[PostController::class,'update'])->middleware('auth:api');
Route::delete('/post/{id}',[PostController::class,'destroy'])->middleware('auth:api');

//============== like management
Route::get('/like/{postId}',[LikeController::class,'getLike'])->middleware('auth:api');
Route::post('/tuggle_like/{PostId}',[LikeController::class,'tuggleLike'])->middleware('auth:api');

//============ comment management 
Route::get('/check-comment/{postId}',[CommentController::class,'show'])->middleware('auth:api');
Route::post('/post_comment/{postid}',[CommentController::class,'store'])->middleware('auth:api');
Route::post('/update-comment/{commentId}',[CommentController::class,'update'])->middleware('auth:api');
Route::delete('/delete-comment/{commentId}',[CommentController::class,'destroy'])->middleware('auth:api');