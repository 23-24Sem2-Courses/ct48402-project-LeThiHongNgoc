//import 'package:flutter/foundation.dart';
import '../../models/product.dart';

class ProductsManager {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/products/product_1.png',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/products/product_2.png',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/products/product_3.png',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/products/product_4.png',
      isFavorite: true,
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  // Product? findById(String id) {
  //   try {
  //     return _items.firstWhere((item) => item.id == id);
  //   } catch (error) {
  //     return null;
  //   }
  // }

  // void addProduct(Product product) {
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //       quantity: 0,
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void updateProduct(Product product) {
  //   final index = _items.indexWhere((item) => item.id == product.id);
  //   if (index >= 0) {
  //     _items[index] = product;
  //     notifyListeners();
  //   }
  // }

  // void toggleFavoriteStatus(Product product) {
  //   final savedStatus = product.isFavorite;
  //   product.isFavorite = !savedStatus;
  // }

  // void deleteProduct(String id) {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   _items.removeAt(index);
  //   notifyListeners();
  // }
}
