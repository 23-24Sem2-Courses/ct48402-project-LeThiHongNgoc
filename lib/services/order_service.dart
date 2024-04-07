import 'dart:convert';
import '../models/order_item.dart';
import 'firebase_service.dart';

class OrderService extends FirebaseService {
  OrderService([super.authToken]);

  Future<List<OrderItem>> fetchOrders({bool filteredByUser = false}) async {
    final List<OrderItem> orders = [];

    try {
      final filters =
          filteredByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      final ordersMap = await httpFetch(
        '$databaseUrl/orders.json?auth=$token&$filters',
      ) as Map<String, dynamic>?;

      ordersMap?.forEach((key, value) {
        orders.add(
          OrderItem.fromJson({
            'id': key,
            ...value,
          }),
        );
      });

      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrderItem(OrderItem orderItem) async {
    try {
      final newOrderItem = await httpFetch(
        '$databaseUrl/orders.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          orderItem.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      ) as Map<String, dynamic>?;
      return orderItem.copyWith(
        id: newOrderItem!['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }
}
