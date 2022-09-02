import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../core/constants/colors.dart';
import '../model/canal.dart';

class CanalCard extends StatelessWidget {
  const CanalCard({Key? key, required this.canal, required this.onTap}) : super(key: key);
  final Canal canal;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.stone[600],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              canal.name,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.stone[100],
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              canal.areas,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.stone[200],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            Divider(
              height: 1,
              indent: 0,
              endIndent: 0,
              color: AppColors.stone[400],
            ),
            const SizedBox(height: 4),
            Text(
              'Solicitações',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.stone[200],
                fontWeight: FontWeight.w700,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.circle_wavy_check,
                        color: AppColors.green[300],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${canal.open}',
                        style: TextStyle(color: AppColors.green[300]),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.hourglass,
                        color: AppColors.orange[700],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${canal.open}',
                        style: TextStyle(color: AppColors.orange[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
