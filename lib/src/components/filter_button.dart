import 'package:flutter/material.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

enum FilterType{open,closed}

class FilterButoon extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final FilterType filterType;
  final bool isActive;

  const FilterButoon({Key? key, this.onPressed, required this.text, this.filterType = FilterType.open, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final color = filterType == FilterType.open ? AppColors.orange[700]: AppColors.green[300];
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: isActive? color : AppColors.stone[300],
        backgroundColor: AppColors.stone[600],
        side: BorderSide(color: isActive? color!: AppColors.stone[600]!,width: 1)
      ),
      child: Text(
        text.toUpperCase(),
      ),
    );
  }
}
