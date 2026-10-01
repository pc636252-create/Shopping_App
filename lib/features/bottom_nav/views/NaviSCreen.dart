import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:danger_now/features/home/controllers/HomeController.dart';
import 'package:danger_now/features/home/views/HomePage.dart';
import 'package:danger_now/features/users/views/Users.dart';
import 'package:danger_now/features/wines/views/WineScreen.dart';
import 'package:danger_now/features/profile/views/profilePage.dart';
import '../../cart/views/cartPage.dart';
import '../controllers/NaviController.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  static const Color activeColor = Color(0xFF38B6FF);

  final NavController controller = Get.put(NavController());
  final HomeController homeController = Get.put(HomeController());

  final List<Widget> screens = [
    HomePage(),
    Users(),
    CartScreen(),
    WineScreen(),
    ProfilePage(name: "Jhone Wick", userEmail: "Jhon123@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 12),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(0, Icons.home, 'Home'),
                _navItem(1, Icons.people, 'Users'),
                _navItem(2, Icons.shopping_cart, 'Cart'),
                _navItem(3, Icons.wine_bar, 'Wines'),
                _navItem(4, Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      final color = isSelected ? activeColor : Colors.grey[600]!;

      return Expanded(
        child: GestureDetector(
          onTap: () => controller.changeTab(index),
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.only(bottom: 4),
                height: 2.5,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}