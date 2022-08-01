import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocket_help/src/core/constants/colors.dart';
import 'package:rocket_help/src/core/theme/app_theme.dart';

class InputText extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;

  final bool expands;
  

  const InputText({
    Key? key,
    this.controller,
    this.icon,
    this.suffixIcon,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.top,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,        
      style: TextStyle(color: AppColors.stone[200], fontSize: 16),
      decoration: AppTheme.inputStyle.copyWith(
        hintText: hintText,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value == null) return null;
        return value.isEmpty ? 'Este campo não pode ser vazio' : null;
      },
      inputFormatters: inputFormatters,
    );
  }
}
