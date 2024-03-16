import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      secondary: Colors.deepOrange,
      background: Colors.white,
      surfaceTint: Colors.grey[200],
    );

    final themData = ThemeData(
      fontFamily: 'Roboto',
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shadowColor: colorScheme.shadow,
      ),
    );
    return MaterialApp(
        title: 'Shoes Store',
        debugShowCheckedModeBanner: false,
        theme: themData,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Shoes Store'),
          ),
          body: const Center(
            child: Text('Welcome to Shoes Store !'),
          ),
        ));
  }
}
