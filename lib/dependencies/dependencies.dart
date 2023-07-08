import 'package:get/get.dart';
import '../Controllers/auth_controller.dart';
import '../Controllers/home_controller.dart';

Future<void> init() async {
  Get.lazyPut<AuthController>(() => AuthController());
  Get.lazyPut<HomeController>(() => HomeController());
}
