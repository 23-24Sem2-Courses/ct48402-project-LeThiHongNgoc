import '/services/cart_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../../models/cart_item.dart';
import '../../models/auth_token.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};
  final CartService _cartService;
  CartManager([AuthToken? authToken]) : _cartService = CartService(authToken);

  set authToken(AuthToken? authToken) {
    _cartService.authToken = authToken;
  }

  Future<void> fetchCartItems() async {
    _items = await _cartService.fetchCartItems(filteredByUser: true);
    notifyListeners();
  }

  Future<void> addItem(Product product) async {
    final CartItem cartItem = CartItem(
        // ignore: invalid_use_of_protected_member
        id: product.id!,
        title: product.title,
        imageUrl: product.imageUrl,
        quantity: 1,
        price: product.price);

    // ignore: invalid_use_of_protected_member
    if (_items.containsKey(product.id)) {
      final existingCartItem =
          cartItem.copyWith(quantity: cartItem.quantity + 1);
      if (await _cartService.updateItem(existingCartItem)) {
        _items.update(
          product.id!,
          (existingCartItem) => existingCartItem.copyWith(
            quantity: existingCartItem.quantity + 1,
          ),
        );
        notifyListeners();
      }
    } else {
      final newCartItem = await _cartService.addItem(cartItem);
      if (newCartItem != null) {
        _items.putIfAbsent(
          product.id!,
          () => newCartItem,
        );
        notifyListeners();
      }
    }
  }

  Future<void> clearItem(String id) async {
    if (_items.containsKey(id)) {
      final existingCartItem = _items[id];
      _items.remove(id);
      notifyListeners();

      if (!await _cartService.clearItem(id)) {
        _items.update(id, (value) => existingCartItem!);
        notifyListeners();
      }
    }
  }

  Future<void> clearAllItems() async {
    if (await _cartService.deleteCart(_items)) {
      _items = {};
      notifyListeners();
    }
  }

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Tạo thêm phương thức thêm sản phẩm theo số lượng nhập vào.
  void addItemWithQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      throw Exception('Quantity must be greater than 0');
    }

    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title,
          imageUrl: product.imageUrl,
          quantity: quantity,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }
}
