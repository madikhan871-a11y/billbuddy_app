import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                'Profile',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(21),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                  BorderRadius.circular(26),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor:
                      AppColors.primaryLight,
                      child: Text(
                        'MN',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Madiha Naz',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Personal bill manager',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Preferences',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 12),

              const _Option(
                icon: Icons.currency_exchange_rounded,
                title: 'Currency',
                subtitle: 'Pakistani Rupee (PKR)',
              ),
              const _Option(
                icon: Icons.notifications_none_rounded,
                title: 'Bill reminders',
                subtitle: 'Get notified before due dates',
              ),
              const _Option(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Monthly budget',
                subtitle: 'Set your monthly spending limit',
              ),
              const _Option(
                icon: Icons.settings_outlined,
                title: 'Settings',
                subtitle: 'App preferences',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _Option({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 7,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.muted,
            size: 19,
          ),
        ],
      ),
    );
  }
}