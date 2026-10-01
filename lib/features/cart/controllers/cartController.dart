import 'package:danger_now/app/routes/AppRoutes.dart';
import 'package:get/get.dart';
import '../../../core/storage/db.helper.dart';

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;
  final DBHelper _db = DBHelper.getInstance;

  @override
  void onInit() {
    super.onInit();
    loadCartFromDB();
    loadWineCartFromDB();
  }

  int get itemCount => items.fold(0, (sum, e) => sum + (e['qty'] as int? ?? 1));

  double get totalPrice => items.fold(0.0, (sum, e) {
    final qty = (e['qty'] as int?) ?? 1;
    final price = _asDouble(e['price']);
    return sum + (price * qty);
  });
  double _asDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
bool isInCart(Map product) => items.any((e) => e['id'] == product['id']);

  Future<void> loadCartFromDB() async {
    final data = await _db.getAllCartItems();
    items.assignAll(data);
  }

  Future<void> addToCart(Map product) async {
    await _db.addToCartDB(Map<String, dynamic>.from(product));
    await loadCartFromDB();
    Get.toNamed(AppRoutes.cart);
    // _snack(product);
  }

  Future<void> increment(int index) async {
    final existing = items[index];
    final newQty = (existing['qty'] as int? ?? 1) + 1;
    await _db.updateCartQty(existing['id'], newQty);
    items[index] = {...existing, 'qty': newQty};
  }

  Future<void> decrement(int index) async {
    final existing = items[index];
    final currentQty = (existing['qty'] as int?) ?? 1;
    if (currentQty <= 1) {
      await _db.removeFromCartDB(existing['id']);
      items.removeAt(index);
    } else {
      final newQty = currentQty - 1;
      await _db.updateCartQty(existing['id'], newQty);
      items[index] = {...existing, 'qty': newQty};
    }
  }

  Future<void> removeFromCart(dynamic id) async {
    await _db.removeFromCartDB(id);
    items.removeWhere((e) => e['id'] == id);
  }
  Future<void> removeAt(int index) async {
    final id = items[index]['id'];
    await _db.removeFromCartDB(id);
    items.removeAt(index);
  }

  Future<void> clearCart() async {
    await _db.clearCartDB();
    items.clear();
  }


  final RxList<Map<String, dynamic>> wineItems = <Map<String, dynamic>>[].obs; // wines

  int get wineItemCount => wineItems.fold(0, (sum, e) => sum + (e['qty'] as int? ?? 1));

  Future<void> loadWineCartFromDB() async {
    final data = await _db.getAllWineCartItems();
    wineItems.assignAll(data);
  }

  Future<void> addWineToCart(Map wine) async {
    await _db.addToWineCartDB(Map<String, dynamic>.from(wine));
    await loadWineCartFromDB();
    Get.toNamed(AppRoutes.cart);
  }

  double get wineTotalPrice => wineItems.fold(0.0, (sum, e) {
    final qty = (e['qty'] as int?) ?? 1;
    final price = _asDoublee(e['winery']);
    return sum + (23 * qty);
  });
  double _asDoublee(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
  bool isICart(Map wine) => wineItems.any((e) => e['id'] == wine['id']);

  Future<void> clearWineCart() async {
    await _db.clearWineCartDB();
    wineItems.clear();
  }

  Future<void> incrementWine(int index) async {
    final existing = wineItems[index];
    final newQty = (existing['qty'] as int? ?? 1) + 1;
    await _db.updateWineCartQty(existing['wine_id'], newQty);
    wineItems[index] = {...existing, 'qty': newQty};
  }
  Future<void> decrementWine(int index) async {
    final existing = wineItems[index];
    final currentQty = (existing['qty'] as int?) ?? 1;
    if (currentQty <= 1) {
      await _db.removeFromWineCartDB(existing['wine_id']);
      wineItems.removeAt(index);
    } else {
      final newQty = currentQty - 1;
      await _db.updateWineCartQty(existing['wine_id'], newQty);
      wineItems[index] = {...existing, 'qty': newQty};
    }
  }

}