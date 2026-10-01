import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeManager {
  // Dynamically get height based on percentage (0.0 to 1.0)
  static double height(double percent) {
    assert(Get.height > 0, 'Get.height is 0. Make sure you are using GetMaterialApp');
    return Get.height * percent;
  }

  // Dynamically get width based on percentage (0.0 to 1.0)
  static double width(double percent) {
    assert(Get.width > 0, 'Get.width is 0. Make sure you are using GetMaterialApp');
    return Get.width * percent;
  }

  // Full screen sizes
  static double get fullHeight {
    assert(Get.height > 0, 'Get.height is 0. Make sure you are using GetMaterialApp');
    return Get.height;
  }

  static double get fullWidth {
    assert(Get.width > 0, 'Get.width is 0. Make sure you are using GetMaterialApp');
    return Get.width;
  }

  // Get height percentage (1 to 100)
  static double heightPercent(double percent) {
    assert(Get.height > 0, 'Get.height is 0. Make sure you are using GetMaterialApp');
    return Get.height * (percent / 100);
  }

  // Get width percentage (1 to 100)
  static double widthPercent(double percent) {
    assert(Get.width > 0, 'Get.width is 0. Make sure you are using GetMaterialApp');
    return Get.width * (percent / 100);
  }

  // Safe area dimensions
  static double get safeHeight {
    final padding = Get.mediaQuery.padding;
    return Get.height - padding.top - padding.bottom;
  }

  static double get safeWidth {
    final padding = Get.mediaQuery.padding;
    return Get.width - padding.left - padding.right;
  }

  // Safe area height with percentage
  static double safeHeightPercent(double percent) => safeHeight * (percent / 100);

  // Safe area width with percentage
  static double safeWidthPercent(double percent) => safeWidth * (percent / 100);

  // Responsive font size based on screen width
  static double fontSize(double size) {
    return size * (Get.width / 375); // 375 is base design width
  }

  // Responsive size (uses smaller dimension for uniform scaling)
  static double responsiveSize(double size) {
    final smallerDimension = Get.width < Get.height ? Get.width : Get.height;
    return size * (smallerDimension / 375);
  }

  // Device type checks
  static bool get isMobile => Get.width < 600;
  static bool get isTablet => Get.width >= 600 && Get.width < 1024;
  static bool get isDesktop => Get.width >= 1024;

  // Orientation
  static bool get isPortrait => Get.height > Get.width;
  static bool get isLandscape => Get.width > Get.height;

  // Common spacing values
  static double get tinySpacing => width(0.01);
  static double get smallSpacing => width(0.02);
  static double get mediumSpacing => width(0.04);
  static double get largeSpacing => width(0.06);
  static double get extraLargeSpacing => width(0.08);

  // Common border radius
  static double get smallRadius => responsiveSize(8);
  static double get mediumRadius => responsiveSize(12);
  static double get largeRadius => responsiveSize(16);
  static double get extraLargeRadius => responsiveSize(24);

  // Status bar and bottom padding
  static double get statusBarHeight => Get.mediaQuery.padding.top;
  static double get bottomPadding => Get.mediaQuery.padding.bottom;

  // AppBar height
  static double get appBarHeight => kToolbarHeight;
}

// Extension for easy access with numbers
extension SizeExtension on num {
  // Percentage-based (0.0 to 1.0)
  double get h => SizeManager.height(toDouble());
  double get w => SizeManager.width(toDouble());

  // Percentage-based (1 to 100)
  double get hp => SizeManager.heightPercent(toDouble());
  double get wp => SizeManager.widthPercent(toDouble());

  // Safe area percentage
  double get shp => SizeManager.safeHeightPercent(toDouble());
  double get swp => SizeManager.safeWidthPercent(toDouble());

  // Font size
  double get sp => SizeManager.fontSize(toDouble());

  // Responsive size
  double get r => SizeManager.responsiveSize(toDouble());
}
