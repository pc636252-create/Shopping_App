import 'package:danger_now/Auth/SplashScreen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SharedPreference/sharedprefrence.dart';
import 'Triall.dart';
import 'View/Location/controller/locationController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LocationController());
  await SharedPrefService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

