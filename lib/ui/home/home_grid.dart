import '/ui/home/home_card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/products_manager.dart';
import '../../models/product.dart';

class HomeGird extends StatelessWidget {
  final bool showFavorites;
  const HomeGird(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();
    // final products =
    //     showFavorites ? productsManager.favoriteItems : productsManager.items;

    // Đọc ra List<Product> sẽ được hiển thị từ ProductsManager
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);
    return GridView.builder(
      padding: const EdgeInsets.all(15.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => HomeCardItem(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 9 / 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    );
  }
}
