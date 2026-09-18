// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../../home/HomePage.dart';
// import '../../service/apiservice.dart';
//
// class LoginController extends GetxController {
//   /// text controller
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   final isObscure = true.obs; /// for password
//   final isLoading = false.obs;/// for loader
//   /// validation
//   String? validate() {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//
//     if (email.isEmpty) return "Please Enter Email";
//     if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email)) {
//       return "Enter valid email (user@example.com)";
//     }
//     if (password.isEmpty) return "Please Enter Password";
//     if (password.length < 6) return "Min 6 characters required";
//     return null;
//   }
//   /// login function call from page
//   Future<void> handleLogin() async {
//     /// prevent multiple clicks
//     if (isLoading.value) return;
//     final error = validate();  /// call validation
//     if (error != null) {       /// if error
//       return;
//     }
//     try {
//       isLoading.value = true;  /// loader start
//     } catch (e) {
//     } finally {
//       isLoading.value = false; /// loader stop
//     }
//   }
//   final isEligible=false.obs;
//  /// Api call Function
//  //  Future<void> whoIAm() async{
//  //    final whoAmI = await ApiService.whoAmI();
//  //    /// make user to get data
//  //    final user = (whoAmI.data as Map<String, dynamic>?)?['user']
//  //    as Map<String, dynamic>?;
//  //    /// user email compare to api email
//  //    if (emailController.text == user?["email"]){
//  //      isEligible.value = true;
//  //      Get.to(()=>HomePage());
//  //    }else{
//  //      isEligible.value = false;
//  //    }
//  //    // if(user?['purchase']?['is_eligible']==1){
//  //    //   isEligible.value=true;
//  //    //   Get.to(()=>HomePage());
//  //    // }else{
//  //    //   isEligible.value=false;
//  //    }
// }

///  New
import 'package:danger_now/View/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Service/apiservice.dart';
import '../../../SharedPreference/sharedprefrence.dart';

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
  //   Future<void> handleLogin() async {
//     /// prevent multiple clicks
//     if (isLoading.value) return;
//     final error = validate();  /// call validation
//     if (error != null) {       /// if error
//       return;
//     }
//     try {
//       isLoading.value = true;  /// loader start
//     } catch (e) {
//     } finally {
//       isLoading.value = false; /// loader stop
//     }
//   }

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (isLoading.value)return;
    final error = validate();
    if(error!= null){
      // Get.snackbar("Error", error,
      //     snackPosition: SnackPosition.TOP,
      //     backgroundColor: Colors.black45,
      //     colorText: Colors.white);
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
        String token = response.data['token'];
        final user = response.data["user"];
        /// Store toke  in Shared preference if needed
        await SharedPrefService().saveToken(token);
        await SharedPrefService().saveUser(
          name: user['name'].toString(),
          email: user['email'].toString(),
        );

        debugPrint("Saved Email: $email");

        Get.snackbar("Success", "Login Successful!",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        // Navigate to Home screen and clear navigation history
        Get.offAll(() => const HomePage());
      }
    } catch (error) {
      Get.snackbar("Login Failed", error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  // Future<void> loginUser() async {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //   if (isLoading.value)return;
  //   final error = validate();
  //   if(error!= null){
  //     Get.snackbar(
  //       "Error", error,
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
  //       borderRadius: 12,
  //       margin: const EdgeInsets.all(12),
  //     );
  //     return;
  //   }
  //   try {
  //     isLoading.value = true;
  //     final response =
  //
  //     await _apiService.login(email, password);
  //     if (response.statusCode == 200) {
  //       String token = response.data['token'];
  //       final user = response.data;
  //       /// Store toke  in Shared preference if needed
  //       await SharedPrefService().saveToken(token);
  //       await SharedPrefService().saveUser(
  //         name: user['name'].toString(),
  //         email: user['email'].toString(),
  //       );
  //
  //
  //       Get.snackbar("Success", "Login Successful!",
  //           snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white);
  //
  //       // Navigate to Home screen and clear navigation history
  //       Get.offAll(() => const HomePage());
  //     }
  //   } catch (error) {
  //     Get.snackbar("Login Failed", error.toString(),
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.red.shade300,
  //         colorText: Colors.white);
  //   } finally {
  //     isLoading.value = false; // Hide loading indicator
  //   }
  // }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
