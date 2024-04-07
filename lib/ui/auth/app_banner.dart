import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
<<<<<<< HEAD
    super.key,
  });
=======
    Key? key,
  }) : super(key: key);
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.symmetric(
<<<<<<< HEAD
        vertical: 10.0,
        horizontal: 70.0,
      ),
      transform: Matrix4.rotationZ(-0 * pi / 360)..translate(-1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal,
=======
        vertical: 8.0,
        horizontal: 94.0,
      ),
      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepOrange.shade900,
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ],
      ),
<<<<<<< HEAD
      child: const Text(
        'Shoes Store',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'Roboto',
=======
      child: Text(
        'MyShop',
        style: TextStyle(
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 50,
          fontFamily: 'Anton',
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
