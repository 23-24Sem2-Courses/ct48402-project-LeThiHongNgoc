import 'package:flutter/material.dart';
import '../products/products_manager.dart';
import 'user_product_list_tile.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Products',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          AddUserProductButton(
            onPressed: () {
              print('Go to edit product screen');
            },
          ),
        ],
      ),
      body: const UserProductList(),
    );
  }
}

class UserProductList extends StatelessWidget {
  const UserProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return ListView.builder(
      itemCount: productsManager.itemCount,
      itemBuilder: (ctx, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.teal,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          print('Product deleted');
        },
        child: Column(
          children: [
            UserProductListTile(
              productsManager.items[i],
              currentIndex: i, // Pass currentIndex here
              onTap: (index) {}, // Pass onTap function here
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class AddUserProductButton extends StatelessWidget {
  const AddUserProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      iconSize: 40,
      color:  const Color(0xff022840),
    );
  }
}
