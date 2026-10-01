import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();

  final isLoading = false.obs;
  final isSent = false.obs;

  String? validateEmail(String? v) =>
      (v == null || !GetUtils.isEmail(v.trim())) ? 'Enter a valid Email' : null;

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    isLoading.value = true;
    try {
      // in feature enter your api ..
      await Future.delayed(const Duration(seconds: 1));
      isSent.value = true;
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void resend() {
    isSent.value = false;
  }

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }
}