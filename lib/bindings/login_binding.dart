import 'package:get/get.dart';
import 'package:todaylang/controllers/login_controller.dart';
import 'package:todaylang/controllers/welcome_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
