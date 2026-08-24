import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/bill.dart';
import '../models/bill_category.dart';
import 'status_badge.dart';

class BillCard extends StatelessWidget {
  final Bill bill;
  final VoidCallback? onTap;

  const BillCard({
    super.key,
    required this.bill,
    this.onTap,
  });

  BillCategory _category() {
    for (final category in BillCategory.all) {
      if (category.name == bill.category) {
        return category;
      }
    }

    return BillCategory.all.last;
  }

  StatusBadge _status() {
    if (bill.paid) {
      return StatusBadge.paid();
    }

    if (bill.isOverdue) {
      return StatusBadge.overdue();
    }

    return StatusBadge.pending();
  }

  String _date() {
    return '${bill.dueDate.day.toString().padLeft(2, '0')}/'
        '${bill.dueDate.month.toString().padLeft(2, '0')}/'
        '${bill.dueDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    final category = _category();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                category.icon,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.name,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${bill.category} • Due ${_date()}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 8,
                    ),
                  ),
                  const SizedBox(height: 7),
                  _status(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Rs. ${bill.amount.toStringAsFixed(0)}',
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}