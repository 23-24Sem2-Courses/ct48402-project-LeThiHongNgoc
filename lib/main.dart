import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/backgrounds/background_6.gif'),
                  fit: BoxFit.contain,
                ),
              ),
              padding: const EdgeInsets.only(top: 500),
              child: SizedBox(
                height: 200,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    child: const Text(
                      'Get start!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      fontFamily: 'Roboto',
      primaryColor: Colors.teal,
      primaryColorDark: const Color(0xff022840),
      appBarTheme: const AppBarTheme(
        color: Colors.teal,
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      colorScheme: const ColorScheme.light(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, CartManager>(
          create: (ctx) => CartManager(),
          update: (ctx, authManager, cartManager) {
            cartManager!.authToken = authManager.authToken;
            return cartManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, OrdersManager>(
          create: (ctx) => OrdersManager(),
          update: (ctx, authManager, orderManager) {
            orderManager!.authToken = authManager.authToken;
            return orderManager;
          },
        ),
      ],
      child: Consumer<AuthManager>(builder: (ctx, authManager, child) {
        return MaterialApp(
          title: 'Shoes Store',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: authManager.isAuth
              ? const SafeArea(child: HomeScreen())
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SafeArea(child: SplashScreen())
                        : const SafeArea(child: AuthScreen());
                  },
                ),
          routes: {
            CartScreen.routeName: (ctx) => const SafeArea(
                  child: CartScreen(),
                ),
            OrdersScreen.routeName: (ctx) => const SafeArea(
                  child: OrdersScreen(),
                ),
            UserProductsScreen.routeName: (ctx) => const SafeArea(
                  child: UserProductsScreen(),
                ),
          },
          onGenerateRoute: (settings) {
            if (settings.name == ProductDetailScreen.routeName) {
              final productId = settings.arguments as String?;
              if (productId != null) {
                final product = ctx.read<ProductsManager>().findById(productId);
                if (product != null) {
                  return MaterialPageRoute(
                    settings: settings,
                    builder: (ctx) {
                      return SafeArea(
                        child: ProductDetailScreen(product),
                      );
                    },
                  );
                }
              }
            }
            if (settings.name == EditProductScreen.routeName) {
              final productId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return SafeArea(
                    child: EditProductScreen(
                      productId != null
                          ? ctx.read<ProductsManager>().findById(productId)
                          : null,
                    ),
                  );
                },
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
