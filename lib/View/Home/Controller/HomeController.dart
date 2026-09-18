import 'dart:async';
import 'package:danger_now/Service/apiservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  final ApiService apiService = ApiService();

  TextEditingController searchController = TextEditingController();

  final ScrollController scrollController = ScrollController();
  RxBool showBottomBar = true.obs;

  var hasDataLoading = false.obs;
  RxList products = [].obs;
  RxList allProducts = [].obs;
  RxBool isLoading = false.obs;
  RxString selectedCategory = "Popular".obs;

  @override
  void onInit() {
    searchController.addListener(() {
      searchProducts(searchController.text);
    });
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBottomBar.value = false;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showBottomBar.value = true;
      }
    });
    fetchPhotos();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void searchProducts(String query) {
    query = query.trim().toLowerCase();

    if (query.isEmpty) {
      products.assignAll(allProducts);
      return;
    }

    products.assignAll(
      allProducts.where((item) {
        final title = (item["title"] ?? "").toString().toLowerCase();
        final category = (item["category"] ?? "").toString().toLowerCase();
        final price = (item["price"] ?? "").toString().toLowerCase();

        return title.contains(query) ||
            category.contains(query) ||
            price.contains(query);
      }).toList(),
    );
  }

  var currentIndex = 0.obs;

  final List<String> imgList =  [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwdD12T-ISWUB9zsqDDy2K6hOvR3-nzpZZlVJWvHia8g&s=10",
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1R-VP660eHbt8GIEgDUlxvglJ-B_c0-th9HmBZN5eJw&s=10',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREe4yFoWW2rI3NYqU5dbC4HQ6JQo8VS6dGBF-YMuWDag&s',
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDj7FWYKtpMHK4giKMKXZRkrmilJ7iFYBA31kOmoOKBg&s=10"
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_mZOg6I9aF9g2Xex6SVSL8f2hiEiQZL88fnSrj8rbhw&s=10"
 ];

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  /// Fetch photos from API
  Future<void> fetchPhotos() async {
    try {
      isLoading.value = true;
      final data = await apiService.fetchPhotos();
      setProducts(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Store fetched data
  void setProducts(List data) {
    allProducts.assignAll(data);
    products.assignAll(data);
  }

  /// Filter locally (used on Home page's own grid, if still needed)
  void filterByCategory(String category) {
    selectedCategory.value = category;

    if (category == "Popular") {
      products.assignAll(allProducts);
    } else {
      products.assignAll(
        allProducts.where((e) => e["category"] == category).toList(),
      );
    }
  }

  List getPhotosByCategory(String category) {
    if (category == "Popular") return List.from(allProducts);

    return allProducts.where((e) {
      final itemCategory = (e["category"] ?? "").toString().trim().toLowerCase();
      return itemCategory == category.trim().toLowerCase();
    }).toList();
  }
}

