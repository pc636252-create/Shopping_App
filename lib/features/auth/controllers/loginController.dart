
import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:danger_now/features/home/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/network/apiservice.dart';
import '../../../core/storage/sharedprefrence.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

    String? validate() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) return "Please Enter Email";
    if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email)) {
      return "Enter valid email (user@example.com)";
    }
    if (password.isEmpty) return "Please Enter Password";
    if (password.length < 6) return "Min 6 characters required";
    return null;
  }


  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (isLoading.value)return;
    final error = validate();
    if(error!= null){
      Get.snackbar(
        "Error", error,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
            borderRadius: 12,
            margin: const EdgeInsets.all(12),
          );
      return;
  }
    try {
      isLoading.value = true;
      final response = await _apiService.login(email, password);
      if (response.statusCode == 200) {
        final token = response.data['token'];

        await SharedPrefService().saveToken(
          token.toString(),
        );

        Get.snackbar(
          "Success",
          "Login Successful!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAndToNamed(AppRoutes.navigation);
      }
    } catch (error) {
      Get.snackbar("Login Failed", error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
