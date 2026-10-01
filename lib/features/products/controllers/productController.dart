import 'package:get/get.dart';

class ProductController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  int get itemCount => cartItems.length;

  void addToCart(Map photo) {
    cartItems.add(Map<String, dynamic>.from(photo));
  }
}