import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(
                () => controller.isSent.value
                ? _successView(context)
                : _formView(context),
          ),
        ),
      ),
    );
  }

  Widget _formView(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Icon(Icons.lock_reset,
              size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          const Text('Forgot Password?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
              'Enter your email address and we can send you password and reset link '),
          const SizedBox(height: 32),
          TextFormField(
            controller: controller.emailC,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (_) => controller.sendResetLink(),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed:
              controller.isLoading.value ? null : controller.sendResetLink,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Send Reset Link',style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () => Get.offNamed(AppRoutes.login),
              child: const Text('Back to Login'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _successView(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.mark_email_read_outlined,
            size: 88, color: Colors.green),
        const SizedBox(height: 24),
        const Text("Send Email",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(
          '${controller.emailC.text.trim()} send email in this Email',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Get.offNamed(AppRoutes.login),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Back to Login',style: TextStyle(color: Colors.white,fontSize: 15),),
          ),
        ),
        TextButton(
          onPressed: controller.resend,
          child: const Text('Send Again '),
        ),
      ],
    );
  }
}