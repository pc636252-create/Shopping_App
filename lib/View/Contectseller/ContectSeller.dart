import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/sellerController.dart';

class ContactSellerSheet {
  static void show({
    required BuildContext context,
    required String sellerName,
    required String sellerPhone,
    required int sellerId,
    required String productName,
  }) {
    final ContactController controller = Get.put(ContactController());

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content tightly
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact $sellerName",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text("Regarding: $productName", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),

            // Option 1: WhatsApp
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.wechat, color: Colors.green),
              ),
              title: Text("Chat on WhatsApp"),
              subtitle: Text("Connect using your phone setup"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Get.back();
                controller.contactViaWhatsApp(
                  phoneNumber: sellerPhone,
                  productName: productName,
                );
              },
            ),
            Divider(),

            // Option 2: Internal Chat
            Obx(() => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: controller.isLoading.value
                    ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Icon(Icons.chat_bubble, color: Colors.blue),
              ),
              title: Text("In-App Messaging"),
              subtitle: Text("Text directly inside the shop application"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: controller.isLoading.value ? null : () {
                Get.back();
                // controller.startInAppChat(
                //   sellerId: sellerId,
                //   productName: productName,
                // );
              },
            )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
