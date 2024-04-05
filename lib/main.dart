import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/home/home_screen.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/user/user_product_screen.dart';
// import 'ui/products/products_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themData = ThemeData(
      fontFamily: 'Roboto',
      primaryColor: const Color(0xff037F8C),
      primaryColorDark: const Color(0xff022840),
      primaryColorLight: const Color(0XFFD1DFDE),
      appBarTheme: const AppBarTheme(
        color: Color(0xff037F8C),
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: const ColorScheme.light(),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xff037F8C),
        selectedItemColor: Color(0xffF2F2F2),
      ),
    );

    return MaterialApp(
      title: 'Shoes Store',
      debugShowCheckedModeBanner: false,
      theme: themData,

      // Hiệu chỉnh trang home
      home: const SafeArea(
        child: HomeScreen(),
        // child: ProductDetailScreen(
        //   ProductsManager().items[2],
        // ),
        // child: UserProductsScreen(),
      ),
    );
  }
}
