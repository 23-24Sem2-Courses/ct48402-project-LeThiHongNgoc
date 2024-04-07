import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/product_detail_screen.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  List<Product> searchTerms = [
    Product(
      id: 'p1',
      title: 'Shoes 1',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/products/product_1.png',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'Shoes 2',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/products/product_2.png',
    ),
    Product(
      id: 'p3',
      title: 'Shoes 3',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/products/product_3.png',
    ),
    Product(
      id: 'p4',
      title: 'Shoes 4',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/products/product_4.png',
      isFavorite: true,
    ),
    Product(
      id: 'p5',
      title: 'Shoes 5',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/products/product_5.png',
      isFavorite: true,
    ),
    Product(
      id: 'p6',
      title: 'Shoes 6',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/products/product_6.png',
      isFavorite: true,
    ),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: Theme.of(context).primaryColorDark,
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).primaryColorDark,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> matchedProducts = searchTerms
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.teal[50],
      child: ListView.builder(
        itemCount: matchedProducts.length,
        itemBuilder: (context, index) {
          var result = matchedProducts[index];
          return ListTile(
            title: Text(
              result.title,
              style: const TextStyle(fontSize: 20),
            ),
            // Display the product image
            leading: Image.asset(
              result.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            // Display the product price
            subtitle: Text(
              '\$${result.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Handle when the user taps on a product
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(result),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> matchedProducts = searchTerms
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.teal[50],
      child: ListView.builder(
        itemCount: matchedProducts.length,
        itemBuilder: (context, index) {
          var result = matchedProducts[index];
          return ListTile(
            title: Text(
              result.title,
              style: const TextStyle(fontSize: 20),
            ),
            // Display the product image
            leading: Image.asset(
              result.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            // Display the product price
            subtitle: Text(
              '\$${result.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Handle when the user taps on a product
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(result),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
