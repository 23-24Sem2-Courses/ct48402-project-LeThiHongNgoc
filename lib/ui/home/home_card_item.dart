import 'package:flutter/material.dart';
import '/ui/products/product_detail_screen.dart';
import '../../models/product.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(this.product, {super.key});

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 7,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              // CardRight
              Expanded(
                flex: 6,
                child: CardRight(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardRight extends StatelessWidget {
  const CardRight({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            product.title,
            style: const TextStyle(
              color: Color(0xFF022840),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            '\$${product.price}',
            style: const TextStyle(
              color: Color(0xFF022840),
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('Add item to cart');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
