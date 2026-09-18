import 'package:danger_now/Constants/AppText.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userInfo = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(userInfo["username"]),
      ),
      body: Center(
        child: SizedBox(
          height: Get.height*0.60,
          width: Get.width*0.80,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userInfo["image"].toString()),
                      // child: Text(user["image"].toString()),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("Name",style: AppTextStyle.formsubtext),
                  Text(userInfo["firstName"],style: AppTextStyle.text),

                  SizedBox(height: 12),
                  Text("Username",style: AppTextStyle.formsubtext),
                  Text(userInfo["username"],style: AppTextStyle.text),
                  SizedBox(height: 12),

                  Text("Email",style: AppTextStyle.formsubtext),
                  Text(userInfo["email"],style: AppTextStyle.text,),
                  SizedBox(height: 12),

                  Text("Phone",style: AppTextStyle.formsubtext),
                  Text(userInfo["phone"],style: AppTextStyle.text),
                  SizedBox(height: 12),

                  Text("Blood Group",style: AppTextStyle.formsubtext),
                  Text(userInfo["bloodGroup"],style: AppTextStyle.text),
                  SizedBox(height: 12),

                  Text("MAC.address",style: AppTextStyle.formsubtext),
                  Text(userInfo["macAddress"],style: AppTextStyle.text),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}