import 'package:get/get.dart';
import 'package:instagram_app/app/controller/account/profile_controller.dart';
import 'package:instagram_app/app/controller/pozt/post_controller.dart';
import 'package:instagram_app/app/model/login_model.dart';
import 'package:instagram_app/app/service/api_service.dart';
import 'package:instagram_app/buttom_nav.dart';
import 'package:quickalert/quickalert.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final _apiService = ApiService();
  final box = GetStorage();

  void login({
    required String email,
    required String password,
  }) async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        text: 'wait for a while you internet is slow !',
      );
      final data = await _apiService.login(
        email: email,
        password: password,
      );
      if (data.token == null) {
        throw Exception("invalid no token , your token is null;");
      }

      setUserData(data.user!);
      setToken(data.token!);
      ProfileController.to.getUserData();
      PostController.to.getPost();
      Get.offAll(() => MyMainNavigation());
      update();
      // when login success
      // QuickAlert.show(
      //   onConfirmBtnTap: () => Get.offAll(MyMainNavigation()),
      //   context: Get.context!,
      //   type: QuickAlertType.success,
      //   text: 'Transaction Completed Successfully!',
      // );
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      );
      print("Error: $e");
    }
    update();
  }

  void setUserData(User user) async {
    var json = user.toJson();
    print("data = $json");
    box.write('user', json);
  }

  void setToken(String token) {
    box.write('token', token);
  }
}
