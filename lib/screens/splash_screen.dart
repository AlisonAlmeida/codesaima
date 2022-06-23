import 'package:codesaima/consts.dart';
import 'package:codesaima/screens/home_page_screen.dart';
import 'package:codesaima/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Hero(
                  tag: 'intro', child: Image.asset(kPathMainLogoCodesaima)),
            ),
          );
        }

        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginScreen();
        }
      },
    ));
  }
}
