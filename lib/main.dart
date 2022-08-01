import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rocket_help/firebase_options.dart';
import 'package:rocket_help/src/core/theme/app_theme.dart';
import 'package:rocket_help/src/screens/detalhes_screen.dart';
import 'package:rocket_help/src/screens/opening_screen.dart';
import 'package:rocket_help/src/screens/orders_screen.dart';
import 'package:rocket_help/src/screens/register_screen.dart';
import 'package:rocket_help/src/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Helper',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const OpeningScreen(),
        '/signin': (context) => const SignInScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/register': (context) => const RegisterScreen(),
        '/datalhes': (context) => const DetalhesScreen(),
      },
    );
  }
}