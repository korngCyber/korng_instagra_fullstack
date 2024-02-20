<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    public function store(Request $request, $postId)
    {
        $validate = $this->validate(
            $request, ['comment' => 'required|string|max:255',]
        );
        $user = Auth::user();
        $post = Post::find($postId);
        if (!$post) {
            return response()->json(['message' => 'post not found']);
        }
        $data = $request->all();
        $data['user_id'] = $user->id;
        $comment = $post->comments()->create($data);
        return response()->json(['comment' => $comment], 200);

    }
    public function show($postId)
    {

        $post = Post::find($postId);
        if (!$post) {
            return response()->json(['message' => 'post not found']);
        }
        $comment = $post->comments()->with('user')->latest()->get();
        return response()->json([
            'success' => true,
            'comment' => $comment
        ], 200);
    }
    public function update(Request $request, $commentId)
    {
        $validate = $this->validate(
            $request, ['comment' => 'required|string|max:255',]
        );
        $user = Auth::user();
        $comment = Comment::find($commentId);
        if (!$comment) {
            return response()->json(['message' => 'post not found']);
        }
        if ($comment->user_id != $user->id) {
            return response()->json(['message' => 'this comment is not your']);
        }
        $comment->update($request->all());
        return response()->json([
            'success' => 'updated comment',
            'comment that update' => $comment
        ]);
    }
    public function destroy($commentId)
    {
        $user = Auth::user();
        $comment = Comment::find($commentId);
        if (!$commentId) {
            return response()->json(['message' => 'commment not found']);
        }
        if ($comment->user_id != $user->id) {
            return response()->json(['message' => 'this comment is not your']);
        }
        $comment->delete();
        return response()->json([
            'message' => 'comment had deleted'
        ]);

    }
}
