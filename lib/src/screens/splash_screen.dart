import 'package:flutter/material.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.stone[700],
      body: Center(
          child: CircularProgressIndicator(
        color: AppColors.stone[200],
      )),
    );
  }
}
