import 'dart:io';
import 'package:danger_now/Auth/LogIn/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constants/AppColors.dart';
import '../../../SharedPreference/sharedprefrence.dart';

class ProfilePageController extends GetxController {
  final SharedPrefService _pref = SharedPrefService();

  final String userName;
  final String userEmail;

  ProfilePageController({required this.userName, required this.userEmail});

  final displayName  = ''.obs;
  final displayEmail = ''.obs;
  final avatarPath   = ''.obs;
  final logoPath     = ''.obs;
  final isLogoSaved  = false.obs;
  final isLoading    = false.obs;

  /// Holds the currently displayed profile image path.
  final selectedImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    displayName.value  = userName;
    displayEmail.value = userEmail;
    loadUser();
    loadSavedImage(); // restore last picked/updated image automatically
  }

  Future<void> loadSavedImage() async {
    try {
      final path = await _pref.getProfileImagePath();
      if (path != null && path.isNotEmpty && await File(path).exists()) {
        selectedImagePath.value = path;
      }
    } catch (e) {
      debugPrint('Failed to load saved image: $e');
    }
  }
  Future<void> pickImageFromAlbum() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        // Update UI instantly
        selectedImagePath.value = pickedFile.path;

        // Persist to SharedPreferences (overwrites old path if any)
        await _pref.saveProfileImagePath(pickedFile.path);

        Get.snackbar(
          'Success',
          'Profile photo updated',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Cancelled',
          'No image was selected',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Remove the saved profile image and fall back to the placeholder.
  Future<void> removeProfileImage() async {
    try {
      await _pref.removeProfileImagePath();
      selectedImagePath.value = '';
      Get.snackbar(
        'Removed',
        'Profile photo removed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Load user data stored locally.
  Future<void> loadUser() async {
    isLoading.value = true;

    final user = await _pref.getUser();
    displayName.value  = user['name'] ?? '';
    displayEmail.value = user['email'] ?? '';

    isLoading.value = false;
  }

  /// Clear local session and send the user back to the login screen.
  Future<void> logout() async {
    await _pref.clearAll();
    Get.offAll(() => LoginPage());
  }

  void openEditProfileDialog(BuildContext context) {
    final nameCtrl  = TextEditingController(text: displayName.value);
    final emailCtrl = TextEditingController(text: displayEmail.value);

    showDialog(
      context: context,
      builder: (_) => _AppDialog(
        title: 'Edit profile',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppField(controller: nameCtrl,  label: "Enter Your Name",  icon: Icons.person_outline_rounded,),
            const SizedBox(height: 14),
            _AppField(controller: emailCtrl, label: "Enter Your Email", icon: Icons.email_outlined),
          ],
        ),
        confirmLabel: 'Save changes',
        confirmColor: AppColors.divider,
        onConfirm: () {
          displayName.value  = nameCtrl.text.trim();
          displayEmail.value = emailCtrl.text.trim();
          Get.back();
        },
      ),
    );
  }

  void openChangePasswordDialog(BuildContext context) {
    final currentCtrl = TextEditingController();
    final newCtrl     = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => _AppDialog(
        title: 'Change password',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppField(controller: currentCtrl, label: 'Current password', obscure: true),
            const SizedBox(height: 14),
            _AppField(controller: newCtrl,     label: 'New password',     obscure: true),
            const SizedBox(height: 14),
            _AppField(controller: confirmCtrl, label: 'Confirm password', obscure: true),
          ],
        ),
        confirmLabel: 'Update password',
        confirmColor: AppColors.success,
        onConfirm: () {
          if (newCtrl.text != confirmCtrl.text) {
            _snack('Passwords don\'t match',
                'Please make sure both fields are identical.',
                icon: Icons.warning_amber_rounded,
                color: AppColors.danger);
            return;
          }
          Get.back();
          _snack('Password updated', 'Your new password is active.',
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.success);
        },
      ),
    );
  }

  Future<void> deleteAccount() async {
    Get.snackbar('Account deleted', 'Your data has been removed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.bgCard,
        colorText: AppColors.textPrimary);
  }

  void _snack(String title, String message,
      {required IconData icon, required Color color}) {
    Get.snackbar(
      title, message,
      icon: Icon(icon, color: color, size: 22),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.textMuted,
      colorText: AppColors.textPrimary,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }
}

class _AppDialog extends StatelessWidget {
  final String     title;
  final Widget     content;
  final String     confirmLabel;
  final Color      confirmColor;
  final VoidCallback onConfirm;

  const _AppDialog({
    required this.title,
    required this.content,
    required this.confirmLabel,
    required this.confirmColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.textMuted,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 17,
          color: AppColors.textPrimary,
        ),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            foregroundColor: confirmColor == AppColors.accent
                ? Colors.black87
                : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: onConfirm,
          child: Text(confirmLabel,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _AppField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscure;

  const _AppField({
    required this.controller,
    required this.label,
    this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
        const TextStyle(color: AppColors.textPrimary, fontSize: 13),
        prefixIcon: icon != null
            ? Icon(icon, size: 19, color: AppColors.textSecondary)
            : null,
        filled: true,
        fillColor: AppColors.bgDeep,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      ),
    );
  }
}
// import 'package:danger_now/Auth/LogIn/login.dart';
// import 'package:danger_now/data/Local/db.helper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../Constants/AppColors.dart';
// import '../../../SharedPreference/sharedprefrence.dart';
//
// class ProfilePageController extends GetxController {
//   final SharedPrefService _pref = SharedPrefService();
//
//   final String userName;
//   final String userEmail;
//
//   ProfilePageController({required this.userName, required this.userEmail});
//
//   final displayName  = ''.obs;
//   final displayEmail = ''.obs;
//   final avatarPath   = ''.obs;
//   final logoPath     = ''.obs;
//   final isLogoSaved  = false.obs;
//   final isLoading    = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     displayName.value  = userName;
//     displayEmail.value = userEmail;
//     loadUser();
//     // loadImages();
//   }
// /// Used
//   var selectedImagePath = ''.obs;
//
//   final ImagePicker _picker = ImagePicker();
//   Future<void> pickImageFromAlbum() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );
//
//       if (pickedFile != null) {
//         selectedImagePath.value = pickedFile.path;
//       } else {
//         Get.snackbar('Cancelled', 'No image was selected',
//             snackPosition: SnackPosition.BOTTOM
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick image: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//
//   /// Load user data stored locally.
//   Future<void> loadUser() async {
//     isLoading.value = true;
//
//     final user = await _pref.getUser();
//     displayName.value  = user['name'] ?? '';
//     displayEmail.value = user['email'] ?? '';
//
//     isLoading.value = false;
//   }
//
//   /// Clear local session and send the user back to the login screen.
//   Future<void> logout() async {
//     await _pref.clearAll();
//     Get.offAll(() => LoginPage()); // remove all routes
//   }
//
//   void openEditProfileDialog(BuildContext context) {
//     final nameCtrl  = TextEditingController(text: displayName.value);
//     final emailCtrl = TextEditingController(text: displayEmail.value);
//
//     showDialog(
//       context: context,
//       builder: (_) => _AppDialog(
//         title: 'Edit profile',
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _AppField(controller: nameCtrl,  label: "Enter Your Name",  icon: Icons.person_outline_rounded,),
//             const SizedBox(height: 14),
//             _AppField(controller: emailCtrl, label: "Enter Your Email", icon: Icons.email_outlined),
//           ],
//         ),
//         confirmLabel: 'Save changes',
//         confirmColor: AppColors.accent,
//         onConfirm: () {
//           displayName.value  = nameCtrl.text.trim();
//           displayEmail.value = emailCtrl.text.trim();
//           Get.back();
//         },
//       ),
//     );
//   }
//
//   void openChangePasswordDialog(BuildContext context) {
//     final currentCtrl = TextEditingController();
//     final newCtrl     = TextEditingController();
//     final confirmCtrl = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => _AppDialog(
//         title: 'Change password',
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _AppField(controller: currentCtrl, label: 'Current password', obscure: true),
//             const SizedBox(height: 14),
//             _AppField(controller: newCtrl,     label: 'New password',     obscure: true),
//             const SizedBox(height: 14),
//             _AppField(controller: confirmCtrl, label: 'Confirm password', obscure: true),
//           ],
//         ),
//         confirmLabel: 'Update password',
//         confirmColor: AppColors.success,
//         onConfirm: () {
//           if (newCtrl.text != confirmCtrl.text) {
//             _snack('Passwords don\'t match',
//                 'Please make sure both fields are identical.',
//                 icon: Icons.warning_amber_rounded,
//                 color: AppColors.danger);
//             return;
//           }
//           Get.back();
//           _snack('Password updated', 'Your new password is active.',
//               icon: Icons.check_circle_outline_rounded,
//               color: AppColors.success);
//         },
//       ),
//     );
//   }
//
//   Future<void> deleteAccount() async {
//     // await YourAuthService.deleteAccount();
//     Get.snackbar('Account deleted', 'Your data has been removed.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.bgCard,
//         colorText: AppColors.textPrimary);
//   }
//
//   // ── helpers
//   void _snack(String title, String message,
//       {required IconData icon, required Color color}) {
//     Get.snackbar(
//       title, message,
//       icon: Icon(icon, color: color, size: 22),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.textMuted,
//       colorText: AppColors.textPrimary,
//       borderRadius: 12,
//       margin: const EdgeInsets.all(16),
//     );
//   }
// }
//
// class _AppDialog extends StatelessWidget {
//   final String     title;
//   final Widget     content;
//   final String     confirmLabel;
//   final Color      confirmColor;
//   final VoidCallback onConfirm;
//
//   const _AppDialog({
//     required this.title,
//     required this.content,
//     required this.confirmLabel,
//     required this.confirmColor,
//     required this.onConfirm,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.textMuted,
//       surfaceTintColor: Colors.transparent,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 17,
//           color: AppColors.textPrimary,
//         ),
//       ),
//       content: content,
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: const Text('Cancel',
//               style: TextStyle(color: AppColors.textSecondary)),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: confirmColor,
//             foregroundColor: confirmColor == AppColors.accent
//                 ? Colors.black87
//                 : Colors.white,
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10)),
//             padding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           ),
//           onPressed: onConfirm,
//           child: Text(confirmLabel,
//               style: const TextStyle(fontWeight: FontWeight.w600)),
//         ),
//       ],
//     );
//   }
// }
//
// class _AppField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final IconData? icon;
//   final bool obscure;
//
//   const _AppField({
//     required this.controller,
//     required this.label,
//     this.icon,
//     this.obscure = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscure,
//       style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle:
//         const TextStyle(color: AppColors.textPrimary, fontSize: 13),
//         prefixIcon: icon != null
//             ? Icon(icon, size: 19, color: AppColors.textSecondary)
//             : null,
//         filled: true,
//         fillColor: AppColors.bgDeep,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: AppColors.divider),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: AppColors.divider),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
//         ),
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//       ),
//     );
//   }
// }
//
