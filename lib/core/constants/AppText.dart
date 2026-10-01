import 'package:flutter/material.dart';
import 'SizeManager.dart';

class AppTextStyle {
  /// change all app titiles
  static  TextStyle title = TextStyle(
    fontSize: SizeManager.height(0.028),
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  /// use to change all app text
  static  TextStyle text = TextStyle(
    fontSize:  SizeManager.height(0.018),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  /// use this to change all app subtitle
  static  TextStyle subtitle = TextStyle(
    fontSize: SizeManager.height(0.015),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  /// use this to change all app detail mein text show in app
  static  TextStyle detailtext =  TextStyle(
    fontSize: SizeManager.height(0.03),
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  );
  /// Sign in submit all buttons use in app
  static  TextStyle clickBotton = TextStyle(
    fontSize: SizeManager.height(0.018),
    color: Colors.white,
  );
  /// delete button in app and also logout or remove
  static  TextStyle deleteBotton = TextStyle(
    fontSize: SizeManager.height(0.02),
    color: Colors.indigo,
  );
  /// show all info of page in detail  by links like terms and conditions
  static const TextStyle linkText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.indigo,
  );
  /// use forms top text in app
  static const TextStyle formsubtext = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

/// Elevated botton in app if you want same elevated botton all app
// static ElevatedButton elevatedButton(
//     String text,
//     VoidCallback onPressed) {
//   return ElevatedButton(
//     onPressed: onPressed,
//     style:  ElevatedButton.styleFrom(
//     backgroundColor: Colors.indigo,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(26)),
//   ), child: Text(text, style: AppTextStyle.clickBotton),
//    );
//  }
}