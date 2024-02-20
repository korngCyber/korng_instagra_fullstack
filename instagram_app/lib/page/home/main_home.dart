import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/page/home/comment_screen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:instagram_app/app/controller/pozt/post_controller.dart';

class MyMainHome extends StatelessWidget {
  MyMainHome({super.key});
  final _postController = Get.put(PostController());
  // final _controller = Get.put(MainHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Instagram',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600]),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 22,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          const Icon(
            Icons.favorite_outline,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              _postController.selectPhoto();
            },
            icon: const Icon(
              CupertinoIcons.camera,
              size: 30,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5)
        ],
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      body: GetBuilder<PostController>(builder: (_) {
        if (_postController.isloading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_postController.postResModel.post == null) {
          return const Center(
            child: Text("no post"),
          );
        }
        return RefreshIndicator(
          onRefresh: () {
            return _postController.getPost();
          },
          child: ListView.builder(
            itemCount: _postController.postResModel.post!.data!.length,
            itemBuilder: (context, index) {
              final post = _postController.postResModel.post!.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              post.user!.profileImage!,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            post.user!.name!,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(Icons.format_list_bulleted_outlined),
                          const SizedBox(width: 15),
                        ],
                      ),
                      const SizedBox(height: 10),
///////////this line is for preview image like a facebook
                      post.image != null
                          ? GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => Scaffold(
                                    appBar: AppBar(
                                      leading: IconButton(
                                          onPressed: () => Get.back(),
                                          icon: const Icon(
                                              Icons.arrow_circle_left)),
                                    ),
                                    body: PhotoView(
                                      enableRotation: true,
                                      imageProvider: NetworkImage(post.image!),
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                  child: Image.network(
                                post.image!,
                                fit: BoxFit.cover,
                              )),
                            )
                          : Container(
                              height: 500,
                              color: Colors.grey,
                              child: const Center(
                                child: Text("No image"),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post.caption!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 130,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _postController.likePost(
                                          postId: post.id!, index: index);
                                    },
                                    icon: Icon(
                                      post.liked!
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_outline,
                                      size: 27,
                                      color: post.liked!
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                  Mycomment(),
                                  const Icon(
                                    CupertinoIcons.share,
                                    size: 27,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.folder_open,
                              size: 27,
                            )
                          ],
                        ),
                      ),
                      // this below is the 3 icon like comment share
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  //there are two style that we can use
                                  "${post.likesCount} Likes ",
                                  // " ${post.likes!.length} likes",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  //there are two style that we can use
                                  "${post.commentsCount} Comments ",
                                  // " ${post.likes!.length} likes",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              "12 minuth ago ",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
