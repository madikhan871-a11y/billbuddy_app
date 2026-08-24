import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: selected
                  ? Colors.white
                  : AppColors.muted,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : AppColors.muted,
                fontSize: 8,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}