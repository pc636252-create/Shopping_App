import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {
  var isLoading = false.obs;

  // 1. Open External WhatsApp App
  Future<void> contactViaWhatsApp({required String phoneNumber, required String productName}) async {
    // Message pre-filled for the buyer
    String message = "Hello! I am interested in buying your product: $productName.";

    // Format the URL for WhatsApp
    final Uri whatsappUrl = Uri.parse(
        "https://wa.me{Uri.encodeComponent(message)}"
    );

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          colorText: Colors.black,
            "Error", "WhatsApp is not installed on this device"
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Could not open WhatsApp");
    }
  }

  // 2. Open Internal In-App Chat (API Call)
  Future<void> startInAppChat({required int sellerId, required String productName}) async {
    try {
      isLoading.value = true;

      // Replace with your real e-commerce chat API endpoint
      final url = Uri.parse('https://dummyjson.com');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "title": "New inquiry for $productName",
          "body": "Buyer wants to start a conversation.",
          "userId": sellerId, // Sending message to the seller ID
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Chat room created! Redirecting...");
        // Get.to(() => RealChatScreen(sellerId: sellerId)); // Navigate to your chat view
      } else {
        Get.snackbar("Server Error", "Failed to connect with seller");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
