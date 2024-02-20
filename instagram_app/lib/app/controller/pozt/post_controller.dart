import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/app/model/comment_res_model.dart';
import 'package:instagram_app/app/model/post_res_model.dart';
import 'package:instagram_app/app/service/api_service.dart';
import 'package:instagram_app/page/post/create_post_screen.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  File? photo;
  final imagePicker = ImagePicker();
  final api = ApiService();
  bool isloading = false;
  bool isGetCmm = false;
  PostResModel postResModel = PostResModel();
  var isComment = false.obs;
  CommentResModel commentResModel = CommentResModel();

  @override
  void onInit() {
    getPost();
    super.onInit();
  }

  void selectPhoto() async {
    final pickFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      photo = File(pickFile.path);
      final result = await Get.to(() => MyCreatePost(photo: photo));
      if (result != null) {
        //refresh data
        getPost();
      }
    }
  }

  Future getPost() async {
    try {
      isloading = true;
      update();
      final posts = await api.getAllPost();
      postResModel = posts;
      print(posts);
      isloading = false;
      update();
    } catch (e) {
      isloading = false;
      update();
      print(e);
    }
  }

  void likePost({required int postId, required int index}) async {
    var post = postResModel.post!.data![index];
    try {
      final success = await api.likeDislike(postId: postId);
      if (success) {
        if (!post.liked!) {
          post.likesCount = post.likesCount! + 1;
        } else {
          post.likesCount = post.likesCount! - 1;
        }
        postResModel.post!.data![index].liked =
            !postResModel.post!.data![index].liked!;
      }
      update();
    } catch (e) {
      print("show error in like ====$e");
    }
  }

  Future getComments({required int postId}) async {
    try {
      isloading = true;
      update();

      final comments = await api.getComments(postId: postId);
      commentResModel = comments;

      print(comments);

      isloading = false;
      update();
    } catch (e) {
      isloading = false;
      update();
      print("Error fetching comments: $e");
    }
  }
}
