import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_app/app/model/login_model.dart';
import 'package:instagram_app/screen/auth/login_screen.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  final box = GetStorage();
  User user = User();
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void logOut() {
    box.remove('token');
    box.remove('user');
    Get.offAll(MyLoginScreen());
    update();
  }

  void getUserData() async {
    // this box.read user read from class login controller make sure bro
    final user = box.read('user');
    // final user = jsonDecode(userString);
    print("user: $user");
    if (user != null) {
      this.user = User.fromJson(user);
      update();
    }
  }
}
