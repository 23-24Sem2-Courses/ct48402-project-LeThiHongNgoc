import 'package:ct484_project/models/product.dart';
import './../screens.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  List<Product> searchTerms;

  CustomSearch(this.searchTerms);

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

    return ListView.builder(
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
