import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/cartController.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              cartController.clearCart();
              cartController.clearWineCart();
            },
          ),
        ],
      ),
      body: Obx(() {
        final hasProducts = cartController.items.isNotEmpty;
        final hasWines = cartController.wineItems.isNotEmpty;
        if (!hasProducts && !hasWines) {
          return const Center(child: Text("Your cart is empty!"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Text("Products",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartController.items.length,
                      itemBuilder: (context, index) {
                        final item = cartController.items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            leading: item['image'] != null
                                ? Image.network(item['image'], width: 50, height: 50, fit: BoxFit.cover)
                                : const Icon(Icons.shopping_bag),
                            title: Text(item['title'] ?? 'Unknown Item'),
                            subtitle: Text("\$${item['price']} x ${item['qty']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => cartController.decrement(index),
                                ),
                                Text("${item['qty']}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => cartController.increment(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                    //   child: Text("Wines",
                    //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    // ),
               Obx(() {
                 // if (cartController.wineItems.isEmpty) {
                 //   return const Center(child: CircularProgressIndicator());
                 // }
                 return
                   ListView.builder(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: cartController.wineItems.length,
                   itemBuilder: (context, index) {
                     final item = cartController.wineItems[index];
                     return Card(
                       margin: const EdgeInsets.symmetric(
                           horizontal: 12, vertical: 6),
                       child: ListTile(
                         leading: item['image'] != null
                             ? Image.network(item['image'], width: 50,
                             height: 50,
                             fit: BoxFit.cover)
                             : const Icon(Icons.wine_bar),
                         title: Text(item['wine'] ?? 'Unknown Wine'),
                         subtitle: Text(
                             "Rating ${item['rating']} x ${item['qty']}"),
                         trailing: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             IconButton(
                               icon: const Icon(Icons.remove_circle_outline),
                               onPressed: () =>
                                   cartController.decrementWine(index),
                             ),
                             Text("${item['qty']}",
                                 style: const TextStyle(fontSize: 16,
                                     fontWeight: FontWeight.bold)),
                             IconButton(
                               icon: const Icon(Icons.add_circle_outline),
                               onPressed: () =>
                                   cartController.incrementWine(index),
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                 );
               }),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items: ${cartController.itemCount + cartController.wineItemCount}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Total: \$${(cartController.totalPrice + cartController.wineTotalPrice).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

