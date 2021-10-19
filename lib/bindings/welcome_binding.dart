import 'package:get/get.dart';
import 'package:todaylang/controllers/welcome_controller.dart';

import '../controllers/home_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
  }
}
