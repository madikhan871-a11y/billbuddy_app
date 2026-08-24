import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;

  const StatusBadge({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
  });

  factory StatusBadge.paid() {
    return const StatusBadge(
      text: 'Paid',
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    );
  }

  factory StatusBadge.pending() {
    return const StatusBadge(
      text: 'Pending',
      background: AppColors.orangeLight,
      foreground: AppColors.orange,
    );
  }

  factory StatusBadge.overdue() {
    return const StatusBadge(
      text: 'Overdue',
      background: AppColors.redLight,
      foreground: AppColors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 8,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}