import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
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
      margin: const EdgeInsets.all(15),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Image.network(
                cartItem.imageUrl,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
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
              onPressed: () async {
                await showConfirmDialog(
                  context,
                  'Bạn muốn xóa sản phẩm này khỏi giỏ hàng?',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
