import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todaylang/controllers/home_controller.dart';
import 'package:todaylang/controllers/welcome_controller.dart';

class WelcomeController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  late User user;
  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    await homeController.googleSign.disconnect();
    await homeController.firebaseAuth.signOut();
  }
}
