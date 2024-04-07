import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../screens.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var customBottomNavigationBar = CustomBottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            // Điều hướng đến trang cửa hàng
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            // Điều hướng đến trang giỏ hàng
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const UserProductsScreen()),
            );
            break;
          case 2:
            // Điều hướng đến trang quản lý
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
            break;
          case 3:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            break;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'D.Sách Giày',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          AddUserProductButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
              );
            },
          ),
          SearchButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
          ),
        ],
      ),
      body: Container(color: Colors.teal[50], child: const UserProductList()),
      bottomNavigationBar: customBottomNavigationBar,
    );
  }
}

class UserProductList extends StatelessWidget {
  const UserProductList({super.key});

  // final Product product;
  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();
    final productsManager = context.watch<ProductsManager>();
    return Consumer<ProductsManager>(builder: (ctx, ProductsManager, child) {
      return ListView.builder(
        itemCount: productsManager.itemCount,
        itemBuilder: (ctx, i) => Dismissible(
          key: UniqueKey(),
          background: Container(
            // color: Colors.teal[50],
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 35,
            ),
          ),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) {
            return showConfirmDialog(
              context,
              'Bạn muốn xóa sản phẩm này ra khỏi danh sách sản phẩm ?',
            );
          },
          onDismissed: (direction) {
            // print('Product deleted');
            // Đọc ra ProductsManager để xóa product
            // context.read<ProductsManager>().deleteProduct(product.id!);
            final product =
                productsManager.items[i]; 
            productsManager.deleteProduct(product.id!); 
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Product deleted',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
          },
          child: Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
                currentIndex: i, // Pass currentIndex here
                onTap: (index) {}, // Pass onTap function here
              ),
            ],
          ),
        ),
      );
    });
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
      color: const Color(0xff022840),
    );
  }
}
