import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/AppColors.dart';
import '../../Constants/AppText.dart';
import 'Controller/Controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  /// controller call in ui page
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final obscurePassword = true.obs;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: Get.height,
        decoration: const BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shop_2_outlined,
                        size: 60,
                        color: Colors.red
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                   Text(
                    "SHOP NOW",
                    style: AppTextStyle.title.copyWith(
                      color: Colors.white
                    )
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Sign in to continue shopping",
                    style: AppTextStyle.clickBotton
                  ),
                  const SizedBox(height: 34),

                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome back",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Email field
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: Colors.indigo),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppColors.danger),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                const BorderSide(color: AppColors.success, width: 1.5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Password field
                          Obx(() => TextFormField(
                            controller: controller.passwordController,
                            obscureText: obscurePassword.value,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: Color(0xFF1565C0)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                                onPressed: () =>
                                obscurePassword.value = !obscurePassword.value,
                              ),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppColors.danger),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:  BorderSide(
                                    color: AppColors.success),
                              ),
                            ),
                          )),

                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Get.to(() => const ForgotPasswordPage());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppTextStyle.subtitle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Login button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: Obx(() => ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.loginUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1565C0),
                                elevation: 3,
                                shadowColor:AppColors.bgCard,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : Text(
                                "Go Next",
                                style: AppTextStyle.clickBotton,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyle.text
                      ),
                      TextButton(
                        onPressed: () {
                          // Get.to(() => const RegisterPage());
                        },
                        child:  Text(
                          "Register",
                          style: AppTextStyle.linkText
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}