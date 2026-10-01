import 'dart:io';
import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/storage/sharedprefrence.dart';

class ProfilePageController extends GetxController {
  final String userName;
  final String userEmail;

  ProfilePageController({this.userName = '', this.userEmail = ''});

  final SharedPrefService _pref = SharedPrefService();
  final ImagePicker _picker = ImagePicker();

  final displayName = ''.obs;
  final displayEmail = ''.obs;
  final logoPath = ''.obs;
  final isLogoSaved = false.obs;
  final isLoading = false.obs;
  final selectedImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
    loadSavedImage();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    try {
      final user = await _pref.getUser();
      displayName.value = (user['name'] ?? '').toString();
      displayEmail.value = (user['email'] ?? '').toString();
    } catch (e) {
      debugPrint('Failed to load user: $e');
    } finally {
      isLoading.value = false;
    }
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
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null) return;

      selectedImagePath.value = file.path;
      await _pref.saveProfileImagePath(file.path);
      Get.snackbar('Success', 'Profile photo updated',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> removeProfileImage() async {
    try {
      await _pref.removeProfileImagePath();
      selectedImagePath.value = '';
      Get.snackbar('Removed', 'Profile photo removed',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove image: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Upload -> Save -> Change (logo button ka flow)
  Future<void> onLogoTap() async {
    if (logoPath.value.isNotEmpty && !isLogoSaved.value) {
      isLogoSaved.value = true;
      _snack('Saved', 'Company logo saved.',
          icon: Icons.check_circle_outline_rounded, color: AppColors.success);
      return;
    }
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null) return;
      logoPath.value = file.path;
      isLogoSaved.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick logo: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> logout() async {
    await _pref.clearAll();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> deleteAccount() async {
    await _pref.clearAll();
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Account deleted', 'Your data has been removed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.bgCard,
        colorText: AppColors.textPrimary);
  }

  void openEditProfileDialog(BuildContext context) {
    final nameCtrl = TextEditingController(
        text: displayName.value.isNotEmpty ? displayName.value : userName);
    final emailCtrl = TextEditingController(
        text: displayEmail.value.isNotEmpty ? displayEmail.value : userEmail);

    showDialog(
      context: context,
      builder: (_) => _AppDialog(
        title: 'Edit profile',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppField(
                controller: nameCtrl,
                label: 'Enter Your Name',
                icon: Icons.person_outline_rounded),
            const SizedBox(height: 14),
            _AppField(
                controller: emailCtrl,
                label: 'Enter Your Email',
                icon: Icons.email_outlined),
          ],
        ),
        confirmLabel: 'Save changes',
        confirmColor: AppColors.divider,
        onConfirm: () {
          displayName.value = nameCtrl.text.trim();
          displayEmail.value = emailCtrl.text.trim();
          Get.back();
        },
      ),
    ).then((_) {
      nameCtrl.dispose();
      emailCtrl.dispose();
    });
  }

  void openChangePasswordDialog(BuildContext context) {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => _AppDialog(
        title: 'Change password',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppField(
                controller: currentCtrl,
                label: 'Current password',
                obscure: true),
            const SizedBox(height: 14),
            _AppField(
                controller: newCtrl, label: 'New password', obscure: true),
            const SizedBox(height: 14),
            _AppField(
                controller: confirmCtrl,
                label: 'Confirm password',
                obscure: true),
          ],
        ),
        confirmLabel: 'Update password',
        confirmColor: AppColors.success,
        onConfirm: () {
          if (newCtrl.text.isEmpty || newCtrl.text != confirmCtrl.text) {
            _snack("Passwords don't match",
                'Please make sure both fields are identical.',
                icon: Icons.warning_amber_rounded, color: AppColors.danger);
            return;
          }
          Get.back();
          _snack('Password updated', 'Your new password is active.',
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.success);
        },
      ),
    ).then((_) {
      currentCtrl.dispose();
      newCtrl.dispose();
      confirmCtrl.dispose();
    });
  }

  void _snack(String title, String message,
      {required IconData icon, required Color color}) {
    Get.snackbar(
      title,
      message,
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
  final String title;
  final Widget content;
  final String confirmLabel;
  final Color confirmColor;
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
            foregroundColor:
            confirmColor == AppColors.accent ? Colors.black87 : Colors.white,
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: c, width: w),
    );

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
        border: border(AppColors.divider),
        enabledBorder: border(AppColors.divider),
        focusedBorder: border(AppColors.accent, 1.5),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      ),
    );
  }
}