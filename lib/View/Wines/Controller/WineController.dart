import 'package:get/get.dart';
import '../../../Service/apiservice.dart';

class WineController extends GetxController {
  ApiService apiService = ApiService();

  var products = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    wiNe();
    super.onInit();
  }

  Future<void> wiNe() async {
    try {
      isLoading.value = true;
      final data =  await apiService.wiNes();
      products.value = data;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}