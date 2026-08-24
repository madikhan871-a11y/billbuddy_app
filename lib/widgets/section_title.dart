import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? action;

  const SectionTitle({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (action != null)
          Text(
            action!,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 8,
              fontWeight: FontWeight.w800,
            ),
          ),
      ],
    );
  }
}