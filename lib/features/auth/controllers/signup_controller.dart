import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmC = TextEditingController();

  final isLoading = false.obs;
  final hidePass = true.obs;
  final hideConfirm = true.obs;

  String? validateName(String? v) =>
      (v == null || v.trim().length < 3) ? '3 character required  ' : null;

  String? validateEmail(String? v) =>
      (v == null || !GetUtils.isEmail(v.trim())) ? 'Valid email daalo' : null;

  String? validatePass(String? v) =>
      (v == null || v.length < 6) ? '6 character required' : null;

  String? validateConfirm(String? v) =>
      v != passC.text ? 'Password match nahi hua' : null;

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmC.dispose();
    super.onClose();
  }
}