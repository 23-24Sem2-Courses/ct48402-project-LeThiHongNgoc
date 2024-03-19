import 'package:flutter/material.dart';
import '/ui/products/product_detail_screen.dart';
import '../../models/product.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          //Hiệu chỉnh footer
          footer: CardFooter(
            product: product,
            onAddToCartPressed: () {
              print('Add item to cart');
            },
          ),
          child: GestureDetector(
            onTap: () {
              //Chuyển đến trang ProductDetailScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ProductDetailScreen(product),
                ),
              );
            },
            child: Container(
              width: 300,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  product.imageUrl,
                  width: 300,
                  height: 150,
                ),
              ),
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
    
    this.onAddToCartPressed,
  });

  final Product product;
  
  final void Function()? onAddToCartPressed;

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
      trailing: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          onPressed: onAddToCartPressed,
          color: Colors.white,
        ),
      ),
    );
  }
}
