import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 70.0,
      ),
      transform: Matrix4.rotationZ(-0 * pi / 360)..translate(-1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: const Text(
        'Shoes Store',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
