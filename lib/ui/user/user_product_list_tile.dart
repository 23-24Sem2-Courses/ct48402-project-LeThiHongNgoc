import 'package:flutter/material.dart';
import '../../models/product.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;
  final int currentIndex;
  final Function(int) onTap;

  const UserProductListTile(
    this.product, {
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
      child: Card(
        color: Colors.grey[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: ListTile(
          contentPadding: const EdgeInsets.all(5.0),
          leading: SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            product.title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          subtitle: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.amber,
            iconSize: 30,
            onPressed: () {
              print('Edit product: ${product.title}');
            },
          ),
        ),
      ),
    );
  }
  //   // return ListTile(
  //     title: Text(product.title),
  //     leading: CircleAvatar(
  //       backgroundImage: AssetImage(product.imageUrl),
  //     ),
  //     trailing: SizedBox(
  //       width: 100,
  //       child: Row(
  //         children: <Widget>[
  //           //Bắt sự kiên cho nút edit
  //           EditUserProductButton(
  //             onPressed: () {
  //               print('Go to edit product screen');
  //             },
  //           ),
  //           //Bắt sự kiên cho nút delete
  //           DeleteUserProductButton(
  //             onPressed: () {
  //               ScaffoldMessenger.of(context)
  //                 ..hideCurrentSnackBar()
  //                 ..showSnackBar(
  //                   const SnackBar(
  //                     content: Text(
  //                       'Delete a product',
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// class DeleteUserProductButton extends StatelessWidget {
//   const DeleteUserProductButton({
//     super.key,
//     this.onPressed,
//   });

//   final void Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: onPressed,
//       icon: const Icon(Icons.delete),
//       color: Theme.of(context).colorScheme.error,
//     );
//   }
// }

// class EditUserProductButton extends StatelessWidget {
//   const EditUserProductButton({
//     super.key,
//     this.onPressed,
//   });

//   final void Function()? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: onPressed, icon: const Icon(Icons.edit), color: Colors.teal);
//   }
// }
