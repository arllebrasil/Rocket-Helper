import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rocket_help/src/screens/canais_screen.dart';
import 'package:rocket_help/src/screens/orders_screen.dart';
import 'package:rocket_help/src/screens/signin_screen.dart';
import 'package:rocket_help/src/screens/splash_screen.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }
        if (snapshot.connectionState == ConnectionState.active &&
            !snapshot.hasData) {
          return const SignInScreen();
        }
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          return const CanaisScreen();
        }
        if (snapshot.hasError) print('HAS ERRO: ${snapshot.error}');
        return const Scaffold(
            body: Center(child: Text('Something went wrong')));
      },
    );
  }
}
