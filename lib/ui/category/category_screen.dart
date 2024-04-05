import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/category/category_card.dart';
import 'package:ct484_project/ui/home/bottom_navigation_bar.dart';
import 'package:ct484_project/ui/home/home_card.dart';
import 'package:ct484_project/ui/order/orders_screen.dart';
import 'package:ct484_project/ui/user/user_product_screen.dart';
import '../search/custom_search.dart';
import 'package:flutter/material.dart';

enum FilterOptions { favorites, all }

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _showOnlyFavorites = false;
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
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
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
            // Điều hướng đến trang yêu thích
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
            break;
          case 3:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            );
            break;
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Product",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          HomeFilterMenu(
            onFilterSelected: (filter) {
              setState(() {
                if (filter == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
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
          ShoppingCartButton(
            onPressed: () {
              print('Go to cart screen');
            },
          ),
        ],
      ),
      body: Container(
        constraints:
            const BoxConstraints.expand(), // Mở rộng hết chiều cao của màn hình
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CategoryCard(_showOnlyFavorites),
            ),
          ],
        ),
      ),
      bottomNavigationBar: customBottomNavigationBar,
    );
  }
}

class HomeFilterMenu extends StatelessWidget {
  const HomeFilterMenu({super.key, this.onFilterSelected});

  final void Function(FilterOptions selectedValue)? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onFilterSelected,
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.search),
      iconSize: 30,
      color: Theme.of(context).primaryColorDark,
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.shopping_cart,
      ),
      iconSize: 30,
      color: Theme.of(context).primaryColorDark,
    );
  }
}

Widget subTitle(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
