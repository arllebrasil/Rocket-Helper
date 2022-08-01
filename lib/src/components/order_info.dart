import 'package:flutter/cupertino.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

class OrderInfo extends StatelessWidget {
  final IconData headerIcon;
  final String title;
  final String? description;
  final Widget? child;
  final String? footer;
  final IconData? footerIcon;

  const OrderInfo({
    Key? key,
    required this.headerIcon,
    required this.title,
    this.description,
    this.child,
    this.footer,
    this.footerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.stone[600],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                headerIcon,
                color: AppColors.purple[700],
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: TextStyle(color: AppColors.stone[300], fontSize: 14),
              ),
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: 12),
            Text(
              description!,
              style: TextStyle(color: AppColors.stone[200], fontSize: 16),
            ),
          ],
          if (child != null) ...[
            const SizedBox(height: 12),
            child!,
          ],
          if (footer != null) ...[
            const SizedBox(height: 12),
            Container(
              color: AppColors.stone[500],
              height: 1,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (footerIcon != null) ...[
                  Icon(footerIcon),
                  const SizedBox(width: 8),
                ],
                Text(
                  footer!,
                  style: TextStyle(
                    color: AppColors.stone[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
