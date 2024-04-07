import 'dart:convert';

import '../models/cart_item.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class CartService extends FirebaseService {
  CartService([AuthToken? authToken]) : super(authToken);

  Future<Map<String, CartItem>> fetchCartItems({bool filteredByUser = false}) async {
    final List<CartItem> cartItems = [];

    try {
      final filters = 
        filteredByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      final cartItemMap = await httpFetch(
        '$databaseUrl/cart.json?auth=$token&$filters',
      ) as Map<String, dynamic>?;

      cartItemMap?.forEach((creatorId, cartItem) {
        cartItems.add(CartItem.fromJson({
          'id': creatorId,
          ...cartItem,
        }));
      });
      
      final cartItemMapResult = { for (var item in cartItems) item.id : item };
      
      return cartItemMapResult;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<CartItem?> addItem(CartItem cartItem) async {
    try {
      final newCartItem = await httpFetch(
        '$databaseUrl/cart.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          cartItem.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      ) as Map<String, dynamic>?;

      return cartItem.copyWith(
        id: newCartItem!['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updateItem(CartItem cartItem) async {
    try {
      await httpFetch(
        '$databaseUrl/cart/$userId.json?auth=$token',
        method: HttpMethod.put,
        body: jsonEncode(cartItem.toJson())
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> clearItem(String id) async {
    try {
      // final filters = 'orderBy="creatorId"&equalTo="$userId"';
      await httpFetch(
        '$databaseUrl/cart/$id.json?auth=$token',
        method: HttpMethod.delete,
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteCart(Map<String, CartItem> cartItems) async {
    try {
      cartItems.forEach((key, value) async {
        await httpFetch(
        '$databaseUrl/cart/$key.json?auth=$token',
        method: HttpMethod.delete,
      );
       });

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
