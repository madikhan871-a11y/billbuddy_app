import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/bill.dart';
import '../widgets/bill_card.dart';
import '../widgets/section_title.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Bill> bills;
  final VoidCallback onAddBill;
  final ValueChanged<Bill> onBillTap;

  const HomeScreen({
    super.key,
    required this.bills,
    required this.onAddBill,
    required this.onBillTap,
  });

  double get total {
    return bills.fold(
      0,
          (sum, bill) => sum + bill.amount,
    );
  }

  double get paid {
    return bills
        .where((bill) => bill.paid)
        .fold(
      0,
          (sum, bill) => sum + bill.amount,
    );
  }

  double get remaining {
    return total - paid;
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = bills
        .where((bill) => !bill.paid)
        .take(3)
        .toList();

    final overdue =
        bills.where((bill) => bill.isOverdue).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            30,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BILLBUDDY',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 8,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Your monthly money map',
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 43,
                    width: 43,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              SummaryCard(
                total: total,
                paid: paid,
                remaining: remaining,
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: _QuickInfo(
                      icon: Icons.schedule_rounded,
                      title: 'Upcoming',
                      value:
                      '${upcoming.length} bills',
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: _QuickInfo(
                      icon: Icons.warning_amber_rounded,
                      title: 'Overdue',
                      value: '$overdue bills',
                      danger: overdue > 0,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SectionTitle(
                title: 'Upcoming bills',
                action: 'View all',
              ),

              const SizedBox(height: 12),

              if (upcoming.isEmpty)
                _EmptyState()
              else
                ...upcoming.map(
                      (bill) => BillCard(
                    bill: bill,
                    onTap: () => onBillTap(bill),
                  ),
                ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: onAddBill,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius:
                    BorderRadius.circular(19),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Add a new bill',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool danger;

  const _QuickInfo({
    required this.icon,
    required this.title,
    required this.value,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: danger
                ? AppColors.red
                : AppColors.orange,
            size: 19,
          ),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 7,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: const Column(
        children: [
          Text(
            '🎉',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 8),
          Text(
            'All bills are handled!',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}