import 'package:flutter/material.dart';

import 'auth_card.dart';
import 'app_banner.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
<<<<<<< HEAD
                  const Color.fromARGB(192, 252, 114, 192).withOpacity(0.5),
                  const Color.fromARGB(255, 116, 2, 168).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 8],
=======
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
<<<<<<< HEAD
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                    child: Text(
                      'Chào mừng bạn đến',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
=======
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
                  const Flexible(
                    child: AppBanner(),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
<<<<<<< HEAD
                  FacebookSignInButton(
                    onPressed: () {},
                  ),
                  GoogleSignInButton(
                    onPressed: () {},
                  ),
=======
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
<<<<<<< HEAD

class FacebookSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FacebookSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(
                    color: Color.fromRGBO(191, 191, 191, 1.0), width: 1),
              ),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Continue with Facebook',
                style: TextStyle(
                  color: Color.fromRGBO(87, 87, 87, 1),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  letterSpacing: 0.3,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(
                    color: Color.fromRGBO(191, 191, 191, 1.0), width: 1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Image.network(
                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Continue with Google',
                style: TextStyle(
                  color: Color.fromRGBO(87, 87, 87, 1),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  letterSpacing: 0.3,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
=======
>>>>>>> b4afc48625cad5c874de557f0ac20f24ecc05c50
