import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/home/bottom_navigation_bar.dart';
import 'package:ct484_project/ui/order/orders_screen.dart';
import 'package:ct484_project/ui/user/user_product_screen.dart';
import '../search/custom_search.dart';
import 'home_card.dart';
import 'package:flutter/material.dart';
import 'home_banner.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
            break;
          case 1:
            // Điều hướng đến trang giỏ hàng
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
            break;
          case 2:
            // Điều hướng đến trang quản lý
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
          "Shoes Store",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 30,
              fontWeight: FontWeight.bold),
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
            const HomeBanner(),
            subTitleWithFilterMenu(
              "All Product",
              HomeFilterMenu(
                onFilterSelected: (filter) {
                  setState(() {
                    _showOnlyFavorites = filter == FilterOptions.favorites;
                  });
                },
              ),
            ),
            Expanded(
              child: HomeCard(_showOnlyFavorites),
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
        Icons.filter_alt,
        size: 30,
        color: Colors.teal,
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
      iconSize: 35,
      color: const Color(0xff022840),
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
      iconSize: 35,
      color: const Color(0xff022840),
    );
  }
}

Widget subTitleWithFilterMenu(String text, Widget filterMenu) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        filterMenu,
      ],
    ),
  );
}
