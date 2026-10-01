import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/App_Pages.dart';
import 'core/storage/sharedprefrence.dart';
import 'features/location/controllers/locationController.dart';

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
      initialRoute: AppRoutes.splash,
      getPages: AppPages.screens,
    );
  }
}

