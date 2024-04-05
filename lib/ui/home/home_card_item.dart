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
        //Chuyển đến trang ProductDetailScreen
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      // onTap: () {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (ctx) => ProductDetailScreen(arguments: product.id),
      //     ),
      //   );
      // },
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
    // this.onFavoritePressed,
    // this.onAddToCartPressed,
  });

  final Product product;
  // final void Function()? onFavoritePressed;
  // final void Function()? onAddToCartPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thêm khoảng trống phía trên để tạo khoảng cách với ảnh
              const SizedBox(height: 12),
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
            ],
          ),
          // Nút trái tim
          Positioned(
            top: 0,
            right: 0,
            child: FavoriteButton(product: product),
          ),
          // Nút giỏ hàng
          const Align(
            alignment: Alignment.bottomRight,
            child: CartButtonBottomRight(),
          ),
        ],
      ),
    );
  }
}

class CartButtonBottomRight extends StatelessWidget {
  const CartButtonBottomRight({
    super.key,
    this.onAddToCartPressed,
  });
  final void Function()? onAddToCartPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: onAddToCartPressed,
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.product,
    this.onFavoritePressed,
  });

  final Product product;
  final void Function()? onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              // Icons.favorite_outline,
              size: 35,
              color: Colors.red,
            ),
            onPressed: onFavoritePressed,
            // onPressed: () {
            //   product.isFavorite = !product.isFavorite;
            // },
          );
        });
  }
}
