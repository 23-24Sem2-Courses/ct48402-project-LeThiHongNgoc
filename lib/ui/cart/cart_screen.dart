import 'package:ct484_project/ui/home/home_screen.dart';
import 'package:ct484_project/ui/search/custom_search.dart';

import '/ui/cart/cart_item_card.dart';
import '/ui/cart/cart_manager.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartManager();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shoes Store",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          SearchButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            //cap nhat CartItemList
            child: CartItemList(cart),
          ),
          const SizedBox(height: 10),
          //cap nhat CartSummary
          CartSummary(
            cart: cart,
            onOnderNowPressed: () {
              print('An order has been added');
            },
          ),
        ],
      ),
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList(
    this.cart, {
    super.key,
  });

  final CartManager cart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CustomCartItemCard(
              productId: entry.key,
              cartItem: entry.value,
            ),
          )
          .toList(),
    );
  }
}

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.cart,
    this.onOnderNowPressed,
  });

  final CartManager cart;
  final void Function()? onOnderNowPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Tổng đơn: \$${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: onOnderNowPressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                backgroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Đặt hàng',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            // const Text(
            //   'Tổng đơn',
            //   style: TextStyle(
            //       fontSize: 24,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold),
            // ),
            // const Spacer(),
            // Chip(
            //   label: Text(
            //     '\$${cart.totalAmount.toStringAsFixed(2)}',
            //     style: const TextStyle(color: Colors.teal, fontSize: 24),
            //   ),
            //   backgroundColor: Colors.white,
            // ),
            // TextButton(
            //   onPressed: onOnderNowPressed,
            //   style: TextButton.styleFrom(
            //     textStyle: const TextStyle(
            //       backgroundColor: Colors.teal,
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Xử lý khi nhấn nút thanh toán
            //     },
            //     child: const Text(
            //       'Đặt hàng',
            //       style: TextStyle(color: Colors.teal),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
