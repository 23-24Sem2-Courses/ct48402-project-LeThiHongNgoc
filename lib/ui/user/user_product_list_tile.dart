import 'package:flutter/material.dart';

import '../../models/product.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;
  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: AssetImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            //Bắt sự kiên cho nút edit
            EditUserProductButton(
              onPressed: () {
                print('Go to edit product screen');
              },
            ),
            //Bắt sự kiên cho nút delete
            DeleteUserProductButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Delete a product',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteUserProductButton extends StatelessWidget {
  const DeleteUserProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );
  }
}

class EditUserProductButton extends StatelessWidget {
  const EditUserProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.edit),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
