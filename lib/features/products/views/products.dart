
  import 'package:danger_now/app/routes/AppRoutes.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import '../../cart/controllers/cartController.dart';
  import '../../contact_seller/views/ContectSeller.dart';


  class ProductPage extends StatefulWidget {
    final Map productDetail;
    const ProductPage({super.key, required this.productDetail});

    @override
    State<ProductPage> createState() => _ProductPageState();
  }

  class _ProductPageState extends State<ProductPage> {
    final PageController _pageController = PageController();
    int _currentPage = 0;

    final CartController cartController = Get.put(CartController(), permanent: true);

    List<String> get _images {
      if (widget.productDetail['images'] != null && widget.productDetail['images'] is List) {
        return List<String>.from(widget.productDetail['images']);
      } else if (widget.productDetail['image'] != null) {
        return [widget.productDetail['image'].toString()];
      }
      return [];
    }

    @override
    Widget build(BuildContext context) {
      final details = widget.productDetail;

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: Get.height * 0.45,
              pinned: true,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () => Get.toNamed(AppRoutes.cart),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Obx(() {
                          final count = cartController.itemCount+cartController.wineItemCount;
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: _images.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (context, index) {
                        return Image.network(
                          _images[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            ),
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: Colors.grey.shade100,
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          },
                        );
                      },
                    ),
                    if (_images.length > 1)
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_images.length, (i) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentPage == i ? 10 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _currentPage == i ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_images.length > 1)
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            final selected = _currentPage == index;
                            return GestureDetector(
                              onTap: () {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selected ? Colors.blue : Colors.grey.shade300,
                                    width: selected ? 2 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: Image.network(_images[index], fit: BoxFit.cover),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),

                    Text(
                      "price : ₹${details['price']?.toString() ?? ''}",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(
                        details['category']?['name']?.toString() ?? 'No Category',
                      ),
                      backgroundColor: Colors.blue.shade50,
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      details['description']?.toString() ?? "No description available.",
                      style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          child:
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              minimumSize: Size(double.infinity, 50),
                            ),
                            icon: Icon(Icons.support_agent, color: Colors.white),
                            label: Text("Contact Seller", style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              ContactSellerSheet.show(
                                context: context,
                                sellerName: "Emily Johnson",
                                sellerPhone: "+819654313024",
                                sellerId: 1,
                                productName: "iPhone 15 Pro",
                              );
                            },
                          )
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: Get.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () => cartController.addToCart(details),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Add to cart", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }