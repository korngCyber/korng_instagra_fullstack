<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $imagePath = null;
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
            'profile_image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',

        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 401);
        }
        // Handle the image upload
        if ($request->hasFile('profile_image')) {
            $image = $request->file('profile_image');
            $name = time() . '.' . $image->getClientOriginalExtension();
            $destinationPath = public_path('/uploads/users');
            $image->move($destinationPath, $name);
            $imagePath = url('/') . '/uploads/users/' . $name;
        }
        // Create the user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'profile_image' => $imagePath,
            'shot_bio' => $request->shot_bio,
        ]);
        // Generate the token
        $token = $user->createToken('authToken')->accessToken;
        // Return the token
        return response()->json(['user' => $user, 'access_token' => $token], 200);
    }
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $token = $user->createToken('authToken')->accessToken;
            // return token with user data
            return response()->json(['token' => $token, 'user' => $user], 200);
        } else {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    }
    // update user profile
    public function updateProfile()
    {
        $user = Auth::user();
        $imagePath = $user->profile_image; 
        // Handle the image upload
        if (request()->hasFile('profile_image')) {
            $image = request()->file('profile_image');
            $name = time() . '.' . $image->getClientOriginalExtension();
            $destinationPath = public_path('/uploads/users');
            $image->move($destinationPath, $name);
            $imagePath = url('/') . '/uploads/users/' . $name;
        }
        // update user profile
        $user->update([
            'name' => request()->name,
            // 'email' => request()->email,
            'profile_image' => $imagePath,
        ]);
        // return updated user data
        return response()->json(['user' => $user], 200);
    }
    // logout user
    public function logout()
    {
        $user = Auth::user()->token();
        $user->revoke();
        return response()->json(['message' => 'User logged out successfully'], 200);
    }

    // delete user account with image from server
    public function deleteAccount()
    {
        $user = Auth::user();
        // delete user profile image from server
        if ($user->profile_image) {
            $imagePath = str_replace(url('/'), '', $user->profile_image);
            unlink(public_path($imagePath));
        }
        // delete user account
        $user->delete();
        return response()->json(['message' => 'User account deleted successfully'], 200);
    }

    public function user()
    {
        $user=Auth::user();
        return response()->json(['user'=>$user],200);
    }

}
