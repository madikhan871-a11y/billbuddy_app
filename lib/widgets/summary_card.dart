import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final double total;
  final double paid;
  final double remaining;

  const SummaryCard({
    super.key,
    required this.total,
    required this.paid,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
    total == 0 ? 0.0 : paid / total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'AUGUST 2026',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 8,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: const Text(
                  'MONTHLY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Total bills',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Rs. ${total.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 17),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 7,
              backgroundColor: Colors.white24,
              valueColor:
              const AlwaysStoppedAnimation<Color>(
                Color(0xFFB9D9C8),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  title: 'Paid',
                  value:
                  'Rs. ${paid.toStringAsFixed(0)}',
                ),
              ),
              Expanded(
                child: _MiniStat(
                  title: 'Remaining',
                  value:
                  'Rs. ${remaining.toStringAsFixed(0)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String title;
  final String value;

  const _MiniStat({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 8,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}