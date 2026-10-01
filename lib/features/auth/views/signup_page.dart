import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text('Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Sign Up and StartShopping'),
                const SizedBox(height: 32),
                TextFormField(
                  controller: controller.nameC,
                  validator: controller.validateName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.emailC,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.passC,
                  validator: controller.validatePass,
                  obscureText: controller.hidePass.value,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.hidePass.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.hidePass.toggle,
                    ),
                  ),
                )),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.confirmC,
                  validator: controller.validateConfirm,
                  obscureText: controller.hideConfirm.value,
                  onFieldSubmitted: (_) => controller.signUp(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(controller.hideConfirm.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: controller.hideConfirm.toggle,
                    ),
                  ),
                )),
                const SizedBox(height: 28),
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.signUp,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Sign Up'),
                  ),
                )),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => Get.offNamed(AppRoutes.login),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}