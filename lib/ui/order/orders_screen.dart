import './../screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final ordersManager = OrdersManager();

    var customBottomNavigationBar = CustomBottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            // Điều hướng đến trang cửa hàng
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            // Điều hướng đến trang giỏ hàng
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const UserProductsScreen()),
            );
            break;
          case 2:
            // Điều hướng đến trang quản lý
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
            break;
          case 3:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đơn hàng",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          SearchButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              // Navigate to CartScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<OrdersManager>(builder: (ctx, ordersManager, child) {
        return Container(
          color: Colors.teal[50],
          child: ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) {
              final order = ordersManager.orders[i];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      }),
      bottomNavigationBar: customBottomNavigationBar,
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
        title: Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: 1000,
        color: Colors.teal[50],
        child: SingleChildScrollView(
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
      ),
    );
  }
}
