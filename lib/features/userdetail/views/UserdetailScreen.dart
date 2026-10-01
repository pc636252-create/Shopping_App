import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/constants/AppText.dart';

class UserDetailsPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const UserDetailsPage({
    super.key,
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userInfo["username"].toString()),
      ),
      body: Center(
        child: SizedBox(
          height: Get.height * 0.60,
          width: Get.width * 0.80,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      userInfo["image"].toString(),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Name",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["firstName"].toString(),
                    style: AppTextStyle.text,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Username",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["username"].toString(),
                    style: AppTextStyle.text,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Email",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["email"].toString(),
                    style: AppTextStyle.text,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Phone",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["phone"].toString(),
                    style: AppTextStyle.text,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Blood Group",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["bloodGroup"].toString(),
                    style: AppTextStyle.text,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "MAC.address",
                    style: AppTextStyle.formsubtext,
                  ),
                  Text(
                    userInfo["macAddress"].toString(),
                    style: AppTextStyle.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}