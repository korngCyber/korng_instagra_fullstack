import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/screen/auth/login_screen.dart';

class MainHomeController extends GetxController {
  final box = GetStorage();
  @override
  void onReady() {
    checkLogin();
    super.onReady();
  }

  void checkLogin() async {
    if (box.read('token') == null) {
      Get.offAll(MyLoginScreen());
    }
    // else {
    //   Get.offAll(MyMainHome());
    // }// this point do not use else is ok
  }
}
