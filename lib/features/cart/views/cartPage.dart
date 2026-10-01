import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cartController.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              controller.clearCart();
              controller.clearWineCart();
            },
          ),
        ],
      ),
      body: Obx(() {
        final hasProducts = controller.items.isNotEmpty;
        final hasWines = controller.wineItems.isNotEmpty;
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
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        final item = controller.items[index];
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
                                  onPressed: () => controller.decrement(index),
                                ),
                                Text("${item['qty']}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => controller.increment(index),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
               Obx(() {
                 return
                   ListView.builder(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: controller.wineItems.length,
                   itemBuilder: (context, index) {
                     final item = controller.wineItems[index];
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
                                   controller.decrementWine(index),
                             ),
                             Text("${item['qty']}",
                                 style: const TextStyle(fontSize: 16,
                                     fontWeight: FontWeight.bold)),
                             IconButton(
                               icon: const Icon(Icons.add_circle_outline),
                               onPressed: () =>
                                   controller.incrementWine(index),
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
                    "Total Items: ${controller.itemCount + controller.wineItemCount}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Total: \$${(controller.totalPrice + controller.wineTotalPrice).toStringAsFixed(2)}",
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

