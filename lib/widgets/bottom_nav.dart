import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        15,
        0,
        15,
        14,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          _Item(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: currentIndex == 0,
            onTap: () => onChanged(0),
          ),
          _Item(
            icon: Icons.receipt_long_outlined,
            label: 'Bills',
            selected: currentIndex == 1,
            onTap: () => onChanged(1),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(2),
              child: Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
          _Item(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            selected: currentIndex == 3,
            onTap: () => onChanged(3),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Item({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected
                  ? AppColors.primary
                  : AppColors.muted,
              size: 21,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? AppColors.primary
                    : AppColors.muted,
                fontSize: 7,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}