import 'dart:io';
import 'package:danger_now/Constants/AppText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/AppColors.dart';
import 'Controller/Controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String userEmail;
  final int    inspections;
  final int    reports;
  final double rating;

  const ProfilePage({
    super.key,
    required this.name,
    required this.userEmail,
    this.inspections = 5,
    this.reports  = 12,
    this.rating  = 8.6,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Uri privacyPolicyUrl = Uri.parse('https://yourdomain.com');
  final Uri termsOfUseUrl = Uri.parse('https://yourdomain.com');

  Future<void> launchPrivacyPolicy() async {
    if (!await launchUrl(privacyPolicyUrl)) {
      throw Exception('Could not launch $privacyPolicyUrl');
    }
  }

  Future<void> launchTermsOfUse() async {
    if (!await launchUrl(termsOfUseUrl)) {
      throw Exception('Could not launch $termsOfUseUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl   = Get.put(ProfilePageController(userName: widget.name, userEmail: widget.userEmail));

    return Scaffold(
        backgroundColor: AppColors.bgDeep,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: Get.height*0.04,
                pinned: true,
                backgroundColor: AppColors.bgDeep,
                elevation: 0,
                leading: _NavButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Get.back(),
                ),
                title:  Text(
                  'Profile',
                  style: AppTextStyle.text
                ),
                actions: [
                  Obx(() {
                    final path = ctrl.logoPath.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 38, height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.divider, width: 1),
                          ),
                          child: path.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.file(File(path), fit: BoxFit.cover),
                          )
                              : const Icon(Icons.business_rounded,
                              color: AppColors.textPrimary, size: 18),
                        ),
                      ),
                    );
                  }),
                ],
                // flexibleSpace: FlexibleSpaceBar(
                //   collapseMode: CollapseMode.parallax,
                //   background: _HeroBackground(),
                // ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                  Container(
                  decoration: const BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, AppColors.bgDeep],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: ctrl.selectedImagePath.value.isNotEmpty
                                ? FileImage(File(ctrl.selectedImagePath.value))
                                : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkKGo5ELFmBgRLe3BPVtB_WxPRlUiR_DeA1YWOSNt4vw&s=10"),
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: InkWell(
                            onTap: () => ctrl.pickImageFromAlbum(),
                            child: const CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 20,
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        ctrl.removeProfileImage();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text("Remove Image",style: AppTextStyle.text,),
                          SizedBox(width: 8),
                          Icon(Icons.input_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                        ctrl.displayName.value.isNotEmpty ? ctrl.displayName.value : ctrl.userName,
                        style: AppTextStyle.title.copyWith(color: AppColors.textPrimary,
                        )
                    )),

                    const SizedBox(height: 4),
                    // Email
                    Obx(() => Text(
                        ctrl.displayEmail.value.isNotEmpty
                            ? ctrl.displayEmail.value
                            : ctrl.userEmail,
                        style: AppTextStyle.text.copyWith(color: AppColors.textPrimary,
                        )
                    )),
                  ],
                ),
              ),
                    SizedBox(height: 25),
                    _StatsCard(
                      inspections: widget.inspections,
                      reports: widget.reports,
                      rating: widget.rating,
                    ),
                    const SizedBox(height: 15),
                    _PrimaryButton(
                      label: 'Edit profile',
                      icon: Icons.edit_rounded,
                      onTap: () => ctrl.openEditProfileDialog(context),
                    ),

                    const SizedBox(height: 8),

                    // Change logo
                    Obx(() => _SecondaryButton(
                      label: ctrl.isLogoSaved.value
                          ? 'Change company logo'
                          : ctrl.logoPath.value.isNotEmpty
                          ? 'Save company logo'
                          : 'Upload company logo',
                      icon: Icons.business_sharp,
                      onTap: () {},
                    )),

                    const SizedBox(height: 32),

                    // ── Account section
                    _SectionLabel('Account'),
                    const SizedBox(height: 10),
                    _SettingsGroup(tiles: [
                      _SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        iconColor: AppColors.bgCardAlt,
                        iconBg: AppColors.textMuted,
                        label: 'Change password',
                        onTap: () => ctrl.openChangePasswordDialog(context),
                      ),
                      _SettingsTile(
                        icon: Icons.shield_outlined,
                          iconColor: AppColors.bgCardAlt,
                          iconBg: AppColors.textMuted,
                        label: 'Privacy policy',
                        onTap: () {
                          launchPrivacyPolicy();
                          },
                      ),
                      _SettingsTile(
                        icon: Icons.description_outlined,
                        iconColor: AppColors.bgCardAlt,
                        iconBg: AppColors.textMuted,
                        label: 'Terms of use',
                        onTap: () {
                          launchTermsOfUse();
                        },
                        showDivider: false,
                      ),
                    ]),

                    const SizedBox(height: 24),

                    // ── Session section ──────────────────────────────────
                    _SectionLabel('Session'),
                    const SizedBox(height: 10),
                    _SettingsGroup(tiles: [
                      _SettingsTile(
                        icon: Icons.logout_rounded,
                        iconColor: AppColors.info,
                        iconBg: AppColors.bgCardAlt,
                        label: 'Sign out',
                        onTap: () => _confirmDialog(
                          context: context,
                          title: 'Sign out ?',
                          message: 'You\'ll need to sign in again to access your account.',
                          confirmLabel: 'Sign out',
                          confirmColor: AppColors.textPrimary,
                          onConfirm: ctrl.logout,
                        ),
                      ),

                      _SettingsTile(
                        icon: Icons.delete_outline_rounded,
                        iconColor: AppColors.bgCardAlt,
                        iconBg: AppColors.textMuted,
                        label: 'Delete account',
                        labelColor: AppColors.danger,
                        showDivider: false,
                        onTap: () => _confirmDialog(
                          context: context,
                          title: 'Delete account?',
                          message:
                          'This is permanent and cannot be undone. '
                              'All your inspections, reports, and data will be removed.',
                          confirmLabel: 'Delete account',
                          confirmColor: AppColors.danger,
                          onConfirm: ctrl.deleteAccount,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 40),
                    // Version footer
                    Center(
                      child: Text(
                        ' Danger.01.0.0',
                        style:AppTextStyle.text.copyWith(color: AppColors.textPrimary)
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
    );
  }

  void _confirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => _AppDialog(
        title: title,
        content: Text(message,
            style:AppTextStyle.text.copyWith(color: AppColors.textPrimary)),
        confirmLabel: confirmLabel,
        confirmColor: confirmColor,
        onConfirm: () {
          Get.back();
          onConfirm();
        },
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final int    inspections;
  final int    reports;
  final double rating;

  const _StatsCard({
    required this.inspections,
    required this.reports,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(child: _Stat(value: '$inspections', label: 'Inspections',)),
          Container(width: 1, height: 40, color: AppColors.divider),
          Expanded(child: _Stat(value: '$reports', label: 'Reports')),
          Container(width: 1, height: 40, color: AppColors.divider),
          Expanded(child: _Stat(value: rating.toStringAsFixed(1), label: 'Rating')),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            )),
        const SizedBox(height: 3),
        Text(label,
            style: AppTextStyle.subtitle.copyWith(
              color: AppColors.textPrimary
            ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 17),
        label: Text(label,
          style:AppTextStyle.text.copyWith(color: AppColors.textPrimary)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          side: const BorderSide(color: AppColors.textPrimary, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 13),
          textStyle: AppTextStyle.clickBotton,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyle.clickBotton.copyWith(color: AppColors.textPrimary)
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsTile> tiles;
  const _SettingsGroup({required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: tiles),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData   icon;
  final Color      iconBg;
  final Color      iconColor;
  final String     label;
  final Color?     labelColor;
  final VoidCallback onTap;
  final bool       showDivider;

  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, color: AppColors.info, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style:AppTextStyle.text.copyWith(color: AppColors.textPrimary)
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 66, right: 16),
            color: AppColors.divider,
          ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon, color: AppColors.textPrimary, size: 17),
      ),
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
        style: AppTextStyle.title
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child:  Text('Cancel',
              style: AppTextStyle.text.copyWith(color: AppColors.textPrimary)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            foregroundColor: confirmColor == AppColors.textMuted
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
