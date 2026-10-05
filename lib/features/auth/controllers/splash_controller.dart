
import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:get/get.dart';
import '../../../core/storage/sharedprefrence.dart';

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
      Get.offAllNamed(AppRoutes.navigation);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}