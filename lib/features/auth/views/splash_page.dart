import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.primary,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutBack,
          builder: (_, v, child) => Opacity(
            opacity: v.clamp(0.0, 1.0),
            child: Transform.scale(scale: v, child: child),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_bag_rounded, size: 96, color: color.onPrimary),
              const SizedBox(height: 16),
              Text(
                'Shopping App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color.onPrimary,
                ),
              ),
              const SizedBox(height: 32),
              CircularProgressIndicator(color: color.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}