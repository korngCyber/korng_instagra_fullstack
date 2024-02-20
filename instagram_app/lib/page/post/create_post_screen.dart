import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/app/controller/pozt/create_post_controller.dart';

class MyCreatePost extends StatelessWidget {
  MyCreatePost({super.key, required this.photo});
  final File? photo;
  final _createpostController = Get.put(CreatePostController());
  final captionControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        actions: [
          IconButton(
            onPressed: () {
              _createpostController.createPost(
                  caption: captionControler.text, photo: photo!);
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: captionControler,
              decoration: const InputDecoration(
                hintText: 'caption',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.file(photo!),
          ],
        ),
      ),
    );
  }
}
