import 'dart:convert';
import '../models/product.dart';
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
      // print(error);
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
      // print(error);
      return null;
    }
  }

  Future<bool> updateProducts(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/products/${product.id}.json?auth=$token',
        method: HttpMethod.patch,
        body: jsonEncode(product.toJson()),
      );

      return true;
    } catch (error) {
      // print(error);
      return false;
    }
  }

  Future<bool> deleteProducts(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/products/$id.json?auth=$token',
        method: HttpMethod.delete,
      );
      return true;
    } catch (error) {
      // print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/userFavorites/$userId/${product.id}.json?auth=$token',
        method: HttpMethod.put,
        body: jsonEncode(product.isFavorite),
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
