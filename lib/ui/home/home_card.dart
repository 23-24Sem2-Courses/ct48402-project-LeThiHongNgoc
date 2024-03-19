import 'package:flutter/material.dart';

import '../products/products_manager.dart';
import 'home_card_item.dart';

class HomeCard extends StatelessWidget {
  final bool showFavorites;
  const HomeCard(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products =
        showFavorites ? productsManager.favoriteItems : productsManager.items;
    return GridView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => HomeCardItem(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
    );
  }
}
