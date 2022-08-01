import 'package:flutter/material.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    fontFamily: 'Roboto Mono',
  );

  static InputDecoration inputStyle = InputDecoration(
    fillColor: AppColors.stone[700],
    filled: true,
    prefixIconColor: AppColors.green[300],
    contentPadding:const EdgeInsets.all(14),
    hintStyle: TextStyle(color:AppColors.stone[300],fontSize: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: Colors.transparent, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColors.green[700]!, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.red[700]!,width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: Colors.red[700]!,width: 1.5),
    ),
  );

  static ButtonStyle primaryButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.green[700]!),
    textStyle: MaterialStateProperty.all(
      TextStyle(color: AppColors.stone.shade100, fontSize:14, fontWeight:FontWeight.bold),
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal:18 ,vertical:16),
    ),
  );
}
