import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //  Backgrounds
  static const Color bgDeep     = Colors.white; // page / scaffold
  static const Color bgCard     = Color(0xFFFFFFFF); // card surface
  static const Color bgCardAlt  = Color(0xFFF4F4F4); // subtle alt surface

  //  Accent
  static const Color accent     = Color(0xFF000000); // amber – primary action
  static const Color accentSoft = Color(0x26F59E0B); // amber at 15% – icon bg

  // Semantic
  static const Color success     = Color(0xFFDDDDDD); // green
  static const Color successSoft = Color(0x1A10B981); // green at 10%
  static const Color danger      = Color(0xFFEF4444); // red
  static const Color dangerSoft  = Color(0x1AEF4444); // red at 10%
  static const Color info        = Color(0xFF0B6FEA); // blue
  static const Color infoSoft    = Color(0x1A60A5FA); // blue at 10%

  // Text
  static const Color textPrimary   = Color(0xFF171515); // headings, body
  static const Color textSecondary = Color(0xFF2A45BF); // subtitles, hints
  static const Color textMuted     = Color(0xFFD5D8DD); // labels, placeholders

  //  Borders & dividers
  static const Color divider = Color(0xFF2D3748);
}