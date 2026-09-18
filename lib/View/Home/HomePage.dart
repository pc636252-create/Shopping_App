import 'dart:async';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:danger_now/View/Home/Controller/HomeController.dart';
import 'package:danger_now/View/ProfilePage/profilePage.dart';
import 'package:danger_now/View/Wines/WineScreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Constants/AppText.dart';
import '../Cartpage/CartPage.dart';
import '../Categories/CategoryProductsPage.dart';
import '../Location/controller/locationController.dart';
import '../Users/Users.dart';
import '../productDetail/productDetail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final LocationController Controller = Get.find();

  var selectedIndex = 0.obs;

  final List<String> categories = [
    "Popular", "Trending", "New", "Offers", "Old items"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5.0,
      ),
      bottomNavigationBar: Obx(
            () => AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: controller.showBottomBar.value
              ? Offset.zero
              : const Offset(0, 0),
          child:
          BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: selectedIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: IconButton(onPressed: (){
                  Get.back();
                }, icon:const Icon(Icons.home_outlined)),
                activeIcon: const Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: IconButton(onPressed: (){
                  Get.to(Users());
                }, icon: Icon(Icons.people_outline)),
                // icon: Icon(Icons.people_outline),
                activeIcon: const Icon(Icons.people),
                label: "Users",
              ),
               BottomNavigationBarItem(
                icon: IconButton(onPressed: (){
                  Get.to(WineScreen());
                },
                icon: Icon(Icons.wine_bar_outlined)),
                activeIcon: Icon(Icons.wine_bar),
                label: "Wines",
              ),
               BottomNavigationBarItem(
                icon: IconButton(onPressed: (){
                  Get.to(CartScreen());
                },
                 icon:Icon(Icons.shopping_cart_outlined)),
                activeIcon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
               BottomNavigationBarItem(
                icon: IconButton(onPressed: (){
                  Get.to(ProfilePage(name: " Jhone Wick", userEmail: "Jhon123@gmail.com"));
                },
                  icon: Icon(Icons.person_outline)),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          )
        ),
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 3),
              Text(
                "Find what you're looking for",
                style: AppTextStyle.text,
              ),
              Obx(() => GestureDetector(
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      Controller.location.value,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.05,
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.searchProducts(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                items: controller.imgList.map((url) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    controller.updateIndex(index);
                  },
                ),
              ),
              const SizedBox(height: 15),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.imgList.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: controller.currentIndex.value == entry.key ? 18.0 : 8.0,
                    height: 5.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: controller.currentIndex.value == entry.key
                          ? Colors.blue
                          : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
              )),
              // Categories
              Text(
                "Categories",
                style: AppTextStyle.formsubtext,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cate = categories[index];

                    return GestureDetector(
                      onTap: () {
                        final filtered = controller.getPhotosByCategory(cate);
                        Get.to(() => CategoryProductsPage(
                          category: cate,
                          photos: filtered,
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: controller.selectedCategory.value == cate
                              ? Colors.red
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          cate,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return _PhotoCard(ProductDetails: controller.products[index]);
                  },
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final Map ProductDetails;
  const _PhotoCard({required this.ProductDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(productDetail: ProductDetails));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  ProductDetails['image'].toString(),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Title + ID
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "price : ₹${ProductDetails['price']?.toString() ?? ''}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.text.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    " ${ProductDetails['category'].toString()}",
                    style: AppTextStyle.linkText.copyWith(
                      fontSize: 12,
                    ),
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