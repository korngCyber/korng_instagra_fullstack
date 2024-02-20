import 'dart:io';

import 'package:get/get.dart';
import 'package:instagram_app/app/service/api_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CreatePostController extends GetxController {
  final api = ApiService();
  void createPost({required String caption, required File photo}) async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        text: 'wait for a while you internet is slow !',
      );
      await api.createPost(caption: caption, photo: photo);
      Get.back();
      Get.back(result: true);
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      );
      print("Error: $e");
    }
  }
}
