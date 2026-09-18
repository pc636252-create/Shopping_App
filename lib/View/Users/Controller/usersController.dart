import 'package:get/get.dart';
import '../../../Service/apiservice.dart';

class UsersController extends GetxController {
  final ApiService apiService = ApiService();

  RxBool isLoading = false.obs;
  RxList<dynamic> users = <dynamic>[].obs;

  /// Go get users
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