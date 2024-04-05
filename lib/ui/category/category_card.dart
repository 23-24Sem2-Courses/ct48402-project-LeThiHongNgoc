import 'package:ct484_project/ui/category/category_card_item.dart';
import 'package:flutter/material.dart';
import '../products/products_manager.dart';


class CategoryCard extends StatelessWidget {
  final bool showFavorites;
  const CategoryCard(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products =
        showFavorites ? productsManager.favoriteItems : productsManager.items;
    return GridView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: products.length,
        itemBuilder: (ctx, i) => CategoryCardItem(products[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
    );
  }
}