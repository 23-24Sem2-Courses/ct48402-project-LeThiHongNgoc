import 'package:ct484_project/ui/order/order_item_cart.dart';
import 'package:flutter/material.dart';
import 'order_manager.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView.builder(
        itemCount: ordersManager.orderCount,
        itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
      ),
    );
  }
}
