import 'package:danger_now/Auth/LogIn/login.dart';
import 'package:danger_now/View/Home/HomePage.dart';
import 'package:get/get.dart';
import '../../../SharedPreference/sharedprefrence.dart';


class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  void _navigate() async {
    final sharedPrefService = SharedPrefService();
    await sharedPrefService.init();

    final token = sharedPrefService.getToken();

    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }
}