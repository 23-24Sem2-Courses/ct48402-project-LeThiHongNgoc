import 'package:ct484_project/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      body: ListView.builder(
        itemCount: ordersManager.orderCount,
        itemBuilder: (ctx, i) {
          final order = ordersManager.orders[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            elevation: 5,
            child: ListTile(
              title: Text(
                'Đơn hàng #${order.id}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(order.dateTime)}',
              ),
              trailing: Text(
                '\$${order.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderDetailScreen(order),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final OrderItem order;

  const OrderDetailScreen(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đơn hàng #${order.id}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Ngày đặt: ${DateFormat('dd/MM/yyyy').format(order.dateTime)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.products.length,
              itemBuilder: (ctx, i) {
                final product = order.products[i];
                return ListTile(
                  title: Text(
                    product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    '${product.quantity} x \$${product.price}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: Text(
                    '\$${(product.quantity * product.price).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                );
              },
            ),
            const Divider(),
            Text(
              'Tổng cộng: \$${order.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
