
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:danger_now/Auth/SplashScreen/Controller/Controller.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});
  final SplashController controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.twenty_mp,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Let’s Go 🚀',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
