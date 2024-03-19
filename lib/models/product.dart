// import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // set isFavorite(bool newValue) {
  //   _isFavorite.value = newValue;
  // }

  // bool get isFavorite {
  //   return _isFavorite.value;
  // }

  // ValueNotifier<bool> get isFavoriteListenable {
  //   return _isFavorite;
  // }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    // required int quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
