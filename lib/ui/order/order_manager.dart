import '/services/order_service.dart';
import '/models/auth_token.dart';
import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../models/order_item.dart';


class OrdersManager with ChangeNotifier {
  List<OrderItem> _orders = [];

  final OrderService _orderService;

  OrdersManager([AuthToken? authToken])
    : _orderService = OrderService(authToken);

  set authToken(AuthToken? authToken) {
    _orderService.authToken = authToken;
  }

  Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders(
      filteredByUser: true,
    );
    notifyListeners();
  }

  Future<void> addOrderItem(List<CartItem> cartProducts, double total) async {
    final orderItem = OrderItem(
      id: 'o${DateTime.now().toIso8601String()}',
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
    );

    final newOrderItem = await _orderService.addOrderItem(orderItem);
    if (newOrderItem != null) {
      _orders.add(newOrderItem);
      notifyListeners();
    }
  }

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
}
