import 'package:get/get.dart';
import '../../../core/network/apiservice.dart';

class UsersController extends GetxController {
  final ApiService apiService = ApiService();

  RxBool isLoading = false.obs;
  RxList<dynamic> users = <dynamic>[].obs;

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;

      final response = await apiService.fetchUsers();
      users.assignAll(response);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }
}