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
  // int _currentIndex = 0;

  // final tabs = [
  //   const Center(child: Text('Store')),
  //   const Center(child: Text('Cart')),
  //   const Center(child: Text('Favorite')),
  //   const Center(child: Text('Profile')),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shoes Store",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeBanner(),
          // tabs[_currentIndex],
          subTitle("All Product"),
          Expanded(
            child: HomeCard(_showOnlyFavorites),
          ),
          subTitle("Best Favorite"),
          Expanded(
            child: HomeCard(!_showOnlyFavorites),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // onTap: (index) {
        //   setState(() {
        //     _currentIndex = index;
        //   });
        // },
      ),
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
    );
  }
}

Widget subTitle(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
