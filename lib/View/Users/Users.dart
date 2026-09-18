import 'package:danger_now/View/Users/Controller/usersController.dart';
import 'package:danger_now/View/Users/UserDetailpage/UserdetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final UsersController controller = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Users"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(),
          );
        }
        return Card(
          elevation: 3,
          child: ListView.builder(
            itemCount: controller.users.length,
              itemBuilder:((context , index){
                final user = controller.users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user["image"].toString()),
                        // child: Text(user["image"].toString()),
                      ),
                      title: Text(user["username"].toString()),
                      subtitle: Text(user["email"].toString()),
                      onTap: (){
                        Get.to(UserDetailsPage(),arguments: user);
                      }
                    ),
                  ],
                );
              })
          ),
        );
      }),
    );
  }
}