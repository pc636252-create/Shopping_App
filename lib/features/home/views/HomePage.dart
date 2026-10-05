import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:danger_now/features/home/controllers/HomeController.dart';
import 'package:danger_now/features/product_details/views/productdetails.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/AppText.dart';
import '../../categories/views/CategoryProductsPage.dart';
import '../../location/controllers/locationController.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());
  final LocationController locationController = Get.find<LocationController>();

  final List<String> categories = const [
    "Popular", "Trending", "New", "Offers", "Old items"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Find what you're looking for", style: AppTextStyle.text),
              const SizedBox(height: 6),
      
              Obx(() => Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red, size: 20),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      locationController.location.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              )),
              const SizedBox(height: 16),
      
              TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: "Search products",
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
      
              /// Banner
              CarouselSlider(
                items: controller.imgList.map((url) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                              child:
                              Icon(Icons.broken_image, color: Colors.grey)),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.85,
                  onPageChanged: (index, reason) =>
                      controller.updateIndex(index),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.imgList.asMap().entries.map((e) {
                  final active = controller.currentIndex.value == e.key;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: active ? 18 : 8,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: active ? Colors.blue : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
              )),
              const SizedBox(height: 20),
              Text("Categories", style: AppTextStyle.formsubtext),
              const SizedBox(height: 12),
              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cate = categories[index];
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCategory.value = cate;
                        Get.to(() => CategoryProductsPage(
                          category: cate,
                          photos: controller.getPhotosByCategory(cate),
                        ));
                      },
                      child: Obx(() {
                        final selected =
                            controller.selectedCategory.value == cate;
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected ? Colors.red : Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(cate,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text("Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (controller.products.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(30),
                    child: Center(child: Text("No products found")),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) =>
                      ProductDetails(productDetails: controller.products[index]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
