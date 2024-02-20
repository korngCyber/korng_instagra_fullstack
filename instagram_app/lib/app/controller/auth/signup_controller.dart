import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import '../../service/api_service.dart';

class SignUpController extends GetxController {
  File? profileImage;
  final _apiService = ApiService();

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
    }
  }

  void register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final res = await _apiService.registerUser(
        email: email,
        password: password,
        name: name,
        profileImage: profileImage,
      );

      if (res) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.success,
          text: 'Transaction Completed Successfully!',
        );
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Failed',
          text:
              'please check your email and password we found that email has already created',
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
