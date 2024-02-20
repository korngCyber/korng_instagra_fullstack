import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/controller/pozt/post_controller.dart';

class Mycomment extends StatelessWidget {
  Mycomment({super.key});
  final _postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.grey[200],
          builder: (context) {
            // Create a FocusNode
            FocusNode commentFocusNode = FocusNode();
            // Add a post-frame callback to request focus once the widget tree is built
            WidgetsBinding.instance.addPostFrameCallback((_) {
              commentFocusNode.requestFocus();
            });
            return GetBuilder<PostController>(builder: (_) {
              if (_postController.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.send,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.41,
                          child: _postController.commentResModel.comment != null
                              ? ListView.builder(
                                  itemCount: _postController
                                      .commentResModel.comment!.length,
                                  itemBuilder: (context, index) {
                                    final comment = _postController
                                        .commentResModel.comment![index];
                                    _postController.getComments(
                                        postId: comment.postId!);
                                    return SingleChildScrollView(
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "${comment.user!.profileImage}"),
                                              radius: 30,
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${comment.user!.name}",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                      "3d",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "${comment.comment} ",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text("Reply"),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite_outline,
                                                size: 30,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("no comment"),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                              ),
                              const SizedBox(width: 10),
                              Container(
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 60,
                                child: TextFormField(
                                  focusNode: commentFocusNode,
                                  decoration: const InputDecoration(
                                    enabled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    hintText: "Add a comment for ",
                                    suffixIcon: Icon(
                                      Icons.gif_outlined,
                                      size: 40,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
          },
        );
      },
      icon: const Icon(
        CupertinoIcons.chat_bubble,
        size: 27,
      ),
    );
  }
}
