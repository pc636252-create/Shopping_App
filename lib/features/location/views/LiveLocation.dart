import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/locationController.dart';

class LocationScreen extends GetView<LocationController>{
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Deliver to",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                controller.location.value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: Obx(
              () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 50,
                color: Colors.red,
              ),
              const SizedBox(height: 20),
              Text(
                controller.location.value,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.getCurrentLocation();
                },
                child: const Text(
                  "Refresh Location",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}