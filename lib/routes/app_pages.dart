import 'package:get/get.dart';
import 'package:todaylang/views/home_view.dart';
import 'package:todaylang/views/login_view.dart';
import 'package:todaylang/views/welcome_view.dart';
import 'package:todaylang/bindings/welcome_binding.dart';
import 'package:todaylang/bindings/home_binding.dart';
import 'package:todaylang/bindings/login_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
  ];
}
