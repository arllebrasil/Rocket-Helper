import 'package:flutter/material.dart';
import 'package:rocket_help/src/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Widget? child;

  const PrimaryButton({Key? key, required this.onPressed, this.text = '', this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: AppTheme.primaryButton,
      child: child ?? Text(text),
    );
  }
}
