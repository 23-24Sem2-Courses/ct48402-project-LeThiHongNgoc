import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD

=======
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
import './ui/screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themData = ThemeData(
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
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
        ChangeNotifierProvider(create: (context) => AuthManager()),
      ],
<<<<<<< HEAD
      child: Consumer<AuthManager>(builder: (ctx, authManager, child) {
        return MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: themData,
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
              final productId = settings.arguments as String;
              return MaterialPageRoute(
                settings: settings,
                builder: (ctx) {
                  return SafeArea(
                    child: ProductDetailScreen(
                      ProductsManager().findById(productId)!,
                    ),
                  );
                },
              );
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
      // child: MaterialApp(
      //   title: 'Shoes Store',
      //   debugShowCheckedModeBanner: false,
      //   theme: themData,
      //   // Hiệu chỉnh trang home
      //   home: const HomeScreen(),
      //   routes: {
      //     CartScreen.routeName: (ctx) => const SafeArea(
      //           child: CartScreen(),
      //         ),
      //     OrdersScreen.routeName: (ctx) => const SafeArea(
      //           child: OrdersScreen(),
      //         ),
      //     UserProductsScreen.routeName: (ctx) => const SafeArea(
      //           child: UserProductsScreen(),
      //         ),
      //   },

      //   onGenerateRoute: (settings) {

      //     if (settings.name == ProductDetailScreen.routeName) {
      //       final productId = settings.arguments as String;
      //       return MaterialPageRoute(
      //         settings: settings,
      //         builder: (ctx) {
      //           return SafeArea(
      //             child: ProductDetailScreen(
      //               ProductsManager().findById(productId)!,
      //             ),
      //           );
      //         },
      //       );
      //     }
      //     if (settings.name == EditProductScreen.routeName) {
      //       final productId = settings.arguments as String?;
      //       return MaterialPageRoute(
      //         builder: (ctx) {
      //           return SafeArea(
      //             child: EditProductScreen(
      //               productId != null
      //                   ? ctx.read<ProductsManager>().findById(productId)
      //                   : null,
      //             ),
      //           );
      //         },
      //       );
      //     }
      //     return null;
      //   },
      // ),
//     );
//   }
// }
=======
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: themData,
            home: authManager.isAuth  
                ? const SafeArea(child: HomeScreen()) 
                : FutureBuilder(
                  future: authManager.tryAutoLogin(), 
                  builder: (ctx, snapshot){
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
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  settings: settings,
                  builder: (ctx) {
                    return SafeArea(
                      child: ProductDetailScreen(
                        ProductsManager().findById(productId)!,
                      ),
                    );
                  },
                );
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
        }
      ),
    );
  }
}
                
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
