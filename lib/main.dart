import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/home/home_screen.dart';

void main() {
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

    return MaterialApp(
      title: 'Shoes Store',
      debugShowCheckedModeBanner: false,
      theme: themData,
      // Hiệu chỉnh trang home
      home: const SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}
