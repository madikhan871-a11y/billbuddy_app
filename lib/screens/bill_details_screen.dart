import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/bill.dart';
import '../models/bill_category.dart';
import '../widgets/status_badge.dart';

class BillDetailsScreen extends StatelessWidget {
  final Bill bill;
  final VoidCallback onMarkPaid;

  const BillDetailsScreen({
    super.key,
    required this.bill,
    required this.onMarkPaid,
  });

  BillCategory get category {
    for (final item in BillCategory.all) {
      if (item.name == bill.category) {
        return item;
      }
    }

    return BillCategory.all.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.text,
        title: const Text(
          'Bill details',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          8,
          18,
          30,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Icon(
                      category.icon,
                      color: AppColors.primary,
                      size: 29,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    bill.name,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bill.category,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rs. ${bill.amount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  bill.paid
                      ? StatusBadge.paid()
                      : bill.isOverdue
                      ? StatusBadge.overdue()
                      : StatusBadge.pending(),
                ],
              ),
            ),

            const SizedBox(height: 14),

            _InfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Due date',
              value:
              '${bill.dueDate.day}/${bill.dueDate.month}/${bill.dueDate.year}',
            ),

            _InfoRow(
              icon: Icons.repeat_rounded,
              title: 'Recurring',
              value:
              bill.recurring ? 'Monthly' : 'One time',
            ),

            _InfoRow(
              icon: Icons.notes_outlined,
              title: 'Notes',
              value: bill.notes == null ||
                  bill.notes!.isEmpty
                  ? 'No notes added'
                  : bill.notes!,
            ),

            const SizedBox(height: 15),

            if (!bill.paid)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onMarkPaid,
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                  ),
                  label: const Text(
                    'Mark as paid',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 19,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 8,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}