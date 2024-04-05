import 'package:flutter/material.dart';
import '/ui/products/product_detail_screen.dart';
import '../../models/product.dart';

class CategoryCardItem extends StatelessWidget {
  const CategoryCardItem(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: CardFooter(product: product),
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class CardFooter extends StatelessWidget {
  const CardFooter({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.title,
              style: const TextStyle(
                color: Color(0xFF022840),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                color: Color(0xFF022840),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            print('Add item to cart');
          },
        ),
      ),
    );
  }
}
