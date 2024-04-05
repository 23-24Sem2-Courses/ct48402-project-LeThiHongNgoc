import 'package:ct484_project/ui/search/custom_search.dart';
// import 'package:ct484_project/ui/user/profile_screen.dart';
import '/ui/home/home_screen.dart';
import '/ui/screens.dart';
// import '/ui/cart/cart_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              "Shoes Store",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 35,
            ),
            title: const Text('Đăng nhập', style: TextStyle(fontSize: 20)),
            onTap: () {
              // TODO: Navigate to login screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.person_add,
              size: 35,
            ),
            title: const Text(
              'Đăng ký',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // TODO: Navigate to registration screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 35,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              setState(() {
                _currentIndex = 3;
              });
            },
          ),
          const SizedBox(height: 382),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            backgroundColor: Colors.teal,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              switch (index) {
                case 0:
                  // Navigate to HomeScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  break;
                case 1:
                  // Navigate to CartScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                  break;
                case 2:
                  // Navigate to OrdersScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const OrdersScreen()),
                  );
                  break;
                // case 3:
                //   // Navigate to ProfileScreen
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //         builder: (context) => const ProfileScreen()),
                //   );
                //   break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_search),
                label: 'Manager',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.badge),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
