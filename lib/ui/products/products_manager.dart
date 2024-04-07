import '/models/auth_token.dart';
import '/services/products_service.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductsManager with ChangeNotifier {
  // final List<Product> _items = [
  // Product(
  //   id: 'p1',
  //   title: 'Shoes 1',
  //   description: 'A red shirt - it is pretty red!',
  //   price: 29.99,
  //   imageUrl: 'assets/images/products/product_1.png',
  //   isFavorite: true,
  // ),
  // Product(
  //   id: 'p2',
  //   title: 'Shoes 2',
  //   description: 'A nice pair of trousers.',
  //   price: 59.99,
  //   imageUrl: 'assets/images/products/product_2.png',
  // ),
  // Product(
  //   id: 'p3',
  //   title: 'Shoes 3',
  //   description: 'Warm and cozy - exactly what you need for the winter.',
  //   price: 19.99,
  //   imageUrl: 'assets/images/products/product_3.png',
  // ),
  // Product(
  //   id: 'p4',
  //   title: 'Shoes 4',
  //   description: 'Prepare any meal you want.',
  //   price: 49.99,
  //   imageUrl: 'assets/images/products/product_4.png',
  //   isFavorite: true,
  // ),
  // Product(
  //   id: 'p5',
  //   title: 'Shoes 5',
  //   description: 'Prepare any meal you want.',
  //   price: 49.99,
  //   imageUrl: 'assets/images/products/product_5.png',
  //   isFavorite: true,
  // ),
  // Product(
  //   id: 'p6',
  //   title: 'Shoes 6',
  //   description: 'Prepare any meal you want.',
  //   price: 49.99,
  //   imageUrl: 'assets/images/products/product_6.png',
  //   isFavorite: true,
  // ),
  // ];

  List<Product> _items = [];
  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts() async {
    _items = await _productsService.fetchProducts();
    notifyListeners();
  }

  Future<void> fetchUserProducts() async {
    _items = await _productsService.fetchProducts(
      filteredByUser: true,
    );
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProducts(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProducts(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  // void addProduct(Product product) {
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
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

  void toggleFavoriteStatus(Product product) {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;
  }

  // void deleteProduct(String id) {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   _items.removeAt(index);
  //   notifyListeners();
  // }
}
