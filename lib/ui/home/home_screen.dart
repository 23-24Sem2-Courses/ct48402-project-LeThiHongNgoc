import 'package:provider/provider.dart';
import '/ui/screens.dart';
import 'package:flutter/material.dart';

enum FilterOptions { favorites, all }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

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
                delegate: CustomSearch(
                  Provider.of<ProductsManager>(context, listen: false).items,
                ),
              );
            },
          ),
          ShoppingCartButton(
            onPressed: () {
              // Navigate to CartScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.teal[50],
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeBanner(),
            subTitleWithFilterMenu(
              "All Product",
              HomeFilterMenu(
                onFilterSelected: (filter) {
                  if (filter == FilterOptions.favorites) {
                    _showOnlyFavorites.value = true;
                  } else {
                    _showOnlyFavorites.value = false;
                  }
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _fetchProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _showOnlyFavorites,
                      builder: (context, onlyFavorites, child) {
                        return HomeGird(onlyFavorites);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
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
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: CartManager().productCount,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CartScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const curve =
                        Curves.bounceIn; // Chỉ định hiệu ứng curve tại đây
                    var begin = const Offset(1.0, 1.0);
                    var end = Offset.zero;
                    var curveTween = CurveTween(curve: curve);
                    var offsetAnimation = animation
                        .drive(curveTween)
                        .drive(Tween(begin: begin, end: end));
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
            iconSize: 35,
            color: const Color(0xff022840),
          ),
        );
      },
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
