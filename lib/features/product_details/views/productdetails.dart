import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../core/constants/AppText.dart';
import '../../../app/routes/AppRoutes.dart';

class ProductDetails extends StatelessWidget {
  final Map productDetails;
  const ProductDetails({super.key, required this.productDetails});

  String get _image {
    if (productDetails['image'] != null) {
      return productDetails['image'].toString();
    }
    final imgs = productDetails['images'];
    if (imgs is List && imgs.isNotEmpty) return imgs.first.toString();
    return '';
  }

  String get _category {
    final c = productDetails['category'];
    if (c is Map) return (c['name'] ?? '').toString();
    return (c ?? '').toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.product,
          arguments: productDetails,
        );
      },      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  _image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image,
                          color: Colors.grey, size: 40),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: Colors.grey.shade100,
                      child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (productDetails['title'] ?? '').toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text("₹${productDetails['price'] ?? ''}",
                      style: AppTextStyle.text.copyWith(fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(
                    _category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.linkText.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}