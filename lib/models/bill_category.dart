import 'package:flutter/material.dart';

class BillCategory {
  final String name;
  final IconData icon;

  const BillCategory({
    required this.name,
    required this.icon,
  });

  static const List<BillCategory> all = [
    BillCategory(
      name: 'Electricity',
      icon: Icons.bolt_rounded,
    ),
    BillCategory(
      name: 'Gas',
      icon: Icons.local_fire_department_outlined,
    ),
    BillCategory(
      name: 'Internet',
      icon: Icons.wifi_rounded,
    ),
    BillCategory(
      name: 'Mobile',
      icon: Icons.phone_android_rounded,
    ),
    BillCategory(
      name: 'Water',
      icon: Icons.water_drop_outlined,
    ),
    BillCategory(
      name: 'Rent',
      icon: Icons.home_outlined,
    ),
    BillCategory(
      name: 'Cable',
      icon: Icons.tv_outlined,
    ),
    BillCategory(
      name: 'Other',
      icon: Icons.receipt_long_outlined,
    ),
  ];
}