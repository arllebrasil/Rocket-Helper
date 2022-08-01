import 'package:flutter/cupertino.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:rocket_help/src/core/constants/colors.dart';

import '../model/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback? onTap;
  const OrderCard({Key? key, required this.order, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final open = order.status == Status.open;
    final color = 
        open ? AppColors.orange[700]
        : AppColors.green[300];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
           color: AppColors.stone[600],
           borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(color: color!, width: 8)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patrimônio ${order.patrimony}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.stone[100],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          PhosphorIcons.timer,
                          size: 12,
                          color: AppColors.stone[200],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          order.when,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.stone[200],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: AppColors.stone[500],
                    child: Icon(
                      open ? PhosphorIcons.hourglass: PhosphorIcons.circle_wavy_check,
                      color: color,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
