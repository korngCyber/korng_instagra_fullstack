<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Post;

class PostController extends Controller
{
    public function index()
    {
        $posts = Post::with('user')->latest()->paginate();
        // $posts=Post::with('user')->get();
        foreach ($posts as $post) {
            $post->likes_count = $post->likes->count();
            $post->comments_count = $post->comments->count();
            $post->liked = $post->likes->contains('user_id', Auth::id());
        }
        return response()->json([
            'success' => true,
            'message ' => 'this all your post',
            'post' => $posts
        ]);
    }
    // public function store(Request $request)
    // {
    //     $imagePath = null;
    //     $data = $request->all();
    //     $user = Auth::user();
    //     if ($user != null) {
    //         if (request()->hasFile('profile_image')) {
    //             $image = request()->file('profile_image');
    //             $name = time() . '.' . $image->getClientOriginalExtension();
    //             $destinationPath = public_path('/uploads/users');
    //             $image->move($destinationPath, $name);
    //             $imagePath = url('/') . '/uploads/users/' . $name;
    //             $data['image'] = $user->image;
    //         }
    //         $data['user_id'] = $user->id;
    //         $post = Post::create($data);
    //         return response()->json(
    //             [
    //                 'success' => true,
    //                 'message' => 'you have posted',
    //                 'data' => $post
    //             ], 200
    //         );
    //     }
    //     return response()->json(['message' => 'falied unauthurize']);
    // }
    public function store(Request $request)
    {
        $imagePath = null;
        $data = $request->all();
        $user = Auth::user();

        if ($user != null) {
            if (request()->hasFile('profile_image')) {
                $image = request()->file('profile_image');
                $name = time() . '.' . $image->getClientOriginalExtension();
                $destinationPath = public_path('/uploads/posts');
                $image->move($destinationPath, $name);
                $imagePath = url('/') . '/uploads/posts/' . $name;
                $data['image'] = $imagePath; // Set it to the new image path
            }
            $data['user_id'] = $user->id;
            $post = Post::create($data);
            return response()->json(
                [
                    'success' => true,
                    'message' => 'You have posted.',
                    'data' => $post
                ], 200
            );
        }

        return response()->json(['message' => 'Failed unauthorized.']);
    
    }

    public function update(Request $request, $id)
    {
        $data = $request->all();
        $user = Auth::user();
        $imagePath = $user->profile_image;
        if ($user != null) {
            $post = Post::find($id);
            if ($post != null) {
                if (request()->hasFile('profile_image')) {
                    $image = request()->file('profile_image');
                    $name = time() . '.' . $image->getClientOriginalExtension();
                    $destinationPath = public_path('/uploads/posts');
                    $image->move($destinationPath, $name);
                    $imagePath = url('/') . '/uploads/posts/' . $name;
                    // Set 'image' to the new image path
                    $data['image'] = $imagePath;
                }
                // Update the post with the new data
                $post->update($data);
                return response()->json(
                    [
                        'success' => true,
                        'message' => 'Post updated successfully',
                        'data' => $post
                    ], 200
                );
            }
    
            return response()->json(['message' => 'Failed, post not found']);
        }
    
        return response()->json(['message' => 'Failed, unauthorized']);
    }
    
    public function destroy($id)
    {
        $user = Auth::user();
        if ($user != null) {
            $post = Post::find($id);
            if ($post != null) {
                $post->delete();
                return response()->json([
                    'success' => true,
                    'message' => 'your post have been delete successfully',
                    'deleted data' => $post
                ]);
            }
            return response()->json(['message' => 'no post data is null']);
        }
        return response()->json(['message' => 'no user in your database']);
    }

}