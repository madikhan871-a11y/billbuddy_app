import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/bill.dart';
import '../widgets/bill_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_title.dart';

class BillsScreen extends StatefulWidget {
  final List<Bill> bills;
  final ValueChanged<Bill> onBillTap;

  const BillsScreen({
    super.key,
    required this.bills,
    required this.onBillTap,
  });

  @override
  State<BillsScreen> createState() =>
      _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  String filter = 'All';

  List<Bill> get filteredBills {
    if (filter == 'Paid') {
      return widget.bills
          .where((bill) => bill.paid)
          .toList();
    }

    if (filter == 'Pending') {
      return widget.bills
          .where(
            (bill) => !bill.paid && !bill.isOverdue,
      )
          .toList();
    }

    if (filter == 'Overdue') {
      return widget.bills
          .where((bill) => bill.isOverdue)
          .toList();
    }

    return widget.bills;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            20,
            18,
            30,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'All bills',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${widget.bills.length} bills in your account',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 9,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _Filter(
                      title: 'All',
                      selected: filter == 'All',
                      onTap: () {
                        setState(() {
                          filter = 'All';
                        });
                      },
                    ),
                    _Filter(
                      title: 'Pending',
                      selected: filter == 'Pending',
                      onTap: () {
                        setState(() {
                          filter = 'Pending';
                        });
                      },
                    ),
                    _Filter(
                      title: 'Paid',
                      selected: filter == 'Paid',
                      onTap: () {
                        setState(() {
                          filter = 'Paid';
                        });
                      },
                    ),
                    _Filter(
                      title: 'Overdue',
                      selected: filter == 'Overdue',
                      onTap: () {
                        setState(() {
                          filter = 'Overdue';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 23),

              const SectionTitle(
                title: 'Your bills',
              ),

              const SizedBox(height: 12),

              if (filteredBills.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      'No bills found.',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              else
                ...filteredBills.map(
                      (bill) => BillCard(
                    bill: bill,
                    onTap: () => widget.onBillTap(bill),
                  ),
                ),

              const SizedBox(height: 18),

              const Text(
                'Categories',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  CategoryChip(
                    title: 'Electricity',
                    icon: Icons.bolt_rounded,
                  ),
                  CategoryChip(
                    title: 'Internet',
                    icon: Icons.wifi_rounded,
                  ),
                  CategoryChip(
                    title: 'Mobile',
                    icon: Icons.phone_android_rounded,
                  ),
                  CategoryChip(
                    title: 'Gas',
                    icon: Icons.local_fire_department_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _Filter({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.white
                : AppColors.muted,
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}