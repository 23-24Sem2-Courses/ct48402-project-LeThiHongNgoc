import 'dart:convert';
import '../models/product.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService([super.authToken]);

  Future<List<Product>> fetchProducts({bool filteredByUser = false}) async {
    final List<Product> products = [];

    try {
      final filters =
          filteredByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      final productsMap = await httpFetch(
        '$databaseUrl/products.json?auth=$token&$filters',
      ) as Map<String, dynamic>?;

      final userFavoritesMap = await httpFetch(
        '$databaseUrl/userFavorites/$userId.json?auth=$token',
      ) as Map<String, dynamic>?;

      productsMap?.forEach((productId, product) {
        final isFavorite = (userFavoritesMap == null)
            ? false
            : (userFavoritesMap[productId] ?? false);
        products.add(
          Product.fromJson({
            'id': productId,
            ...product,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final newProduct = await httpFetch(
        '$databaseUrl/products.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          product.toJson()
            ..addAll({
              'creatorId': userId,
            }),
        ),
      ) as Map<String, dynamic>?;

      return product.copyWith(
        id: newProduct!['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }
}
