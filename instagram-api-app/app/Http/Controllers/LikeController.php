<?php

namespace App\Http\Controllers;

use App\Models\Like;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
    public function getLike($postId)
    {
        $post=Like::where('post_id',$postId)->with('user')->get();
        $user=$post->pluck('user');
        return response()->json(['data'=>$user],200);
    }
    // public function tuggleLike($postId)
    // {
    //     $user=Auth::user();
    //     $post=Post::find($postId);
    //     $liked=$post->likes->contain('user_id',$user->id);
    //     if(!$liked)
    //     {
    //         $post->likes()->where('user_id',$user->id)->delete();
    //         return response()->json(['message'=>'Post dislike']);

    //     }else{
    //         $post->likes()->create(
    //             [
    //                 'user_id'=>$user->id,
    //                 'post_id'=>$postId
    //             ]
    //         );
    //         return response()->json([
    //             'message'=>'liked the post'
    //         ],200);
    //     }
    // }
    public function tuggleLike($postId)
{
    $user = Auth::user();
    $post = Post::find($postId);

    // Check if the user has already liked the post
    $liked = $post->likes->contains('user_id', $user->id);

    if ($liked) {
        // If liked, unlike the post
        $post->likes()->where('user_id', $user->id)->delete();
        return response()->json(['message' => 'Post dislike']);
    } else {
        // If not liked, like the post
        $post->likes()->create([
            'user_id' => $user->id,
            'post_id' => $postId
        ]);
        return response()->json(['message' => 'Liked the post'], 200);
    }
}

}
