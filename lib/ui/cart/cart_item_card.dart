import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../cart/cart_manager.dart';
import '../shared/dialog_utils.dart';

class CustomCartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CustomCartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[400]),
              child: Image.asset(
                cartItem.imageUrl,
                width: 150,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Giá: \$${cartItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SL: ${cartItem.quantity}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 35,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Xác nhận xóa sản phẩm'),
                    content:
                        const Text('Bạn muốn xóa sản phẩm này khỏi giỏ hàng?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Hủy'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<CartManager>().clearItem(productId);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Xóa'),
                      ),
                    ],
                  ),
                );
              },
              // onPressed: () {
              //   await showConfirmDialog(
              //     context.read<CartManager>().clearItem(productId),
              //     'Bạn muốn xóa sản phẩm này khỏi giỏ hàng?',
              //   );
              // },
            ),
          ],
        ),
      ),
    );
  }
}
