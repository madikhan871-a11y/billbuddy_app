import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'models/bill.dart';
import 'screens/add_bill_screen.dart';
import 'screens/bill_details_screen.dart';
import 'screens/bills_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const BillBuddyApp());
}

class BillBuddyApp extends StatefulWidget {
  const BillBuddyApp({super.key});

  @override
  State<BillBuddyApp> createState() =>
      _BillBuddyAppState();
}

class _BillBuddyAppState extends State<BillBuddyApp> {
  int currentIndex = 0;

  final List<Bill> bills = [
    Bill(
      id: '1',
      name: 'LESCO Electricity',
      category: 'Electricity',
      amount: 4850,
      dueDate: DateTime(2026, 8, 25),
      recurring: true,
      paid: false,
      notes: 'Monthly electricity bill',
    ),
    Bill(
      id: '2',
      name: 'SNGPL Gas',
      category: 'Gas',
      amount: 1850,
      dueDate: DateTime(2026, 8, 20),
      recurring: true,
      paid: true,
      notes: 'House gas bill',
    ),
    Bill(
      id: '3',
      name: 'Internet',
      category: 'Internet',
      amount: 2500,
      dueDate: DateTime(2026, 8, 28),
      recurring: true,
      paid: false,
      notes: 'Home internet',
    ),
    Bill(
      id: '4',
      name: 'Mobile Package',
      category: 'Mobile',
      amount: 1200,
      dueDate: DateTime(2026, 8, 30),
      recurring: true,
      paid: false,
    ),
    Bill(
      id: '5',
      name: 'Water Bill',
      category: 'Water',
      amount: 950,
      dueDate: DateTime(2026, 8, 18),
      recurring: true,
      paid: true,
    ),
    Bill(
      id: '6',
      name: 'Home Rent',
      category: 'Rent',
      amount: 18000,
      dueDate: DateTime(2026, 8, 5),
      recurring: true,
      paid: true,
      notes: 'Monthly house rent',
    ),
  ];

  void openBill(Bill bill) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BillDetailsScreen(
            bill: bill,
            onMarkPaid: () {
              markAsPaid(bill);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void markAsPaid(Bill bill) {
    final index = bills.indexWhere(
          (item) => item.id == bill.id,
    );

    if (index == -1) return;

    setState(() {
      bills[index] = Bill(
        id: bill.id,
        name: bill.name,
        category: bill.category,
        amount: bill.amount,
        dueDate: bill.dueDate,
        recurring: bill.recurring,
        paid: true,
        notes: bill.notes,
      );
    });
  }

  void addBill(Bill bill) {
    setState(() {
      bills.insert(0, bill);
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Bill added successfully.',
        ),
      ),
    );
  }

  void openAddBill() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddBillScreen(
            onSave: addBill,
          );
        },
      ),
    );
  }

  Widget currentScreen() {
    if (currentIndex == 1) {
      return BillsScreen(
        bills: bills,
        onBillTap: openBill,
      );
    }

    if (currentIndex == 3) {
      return const ProfileScreen();
    }

    return HomeScreen(
      bills: bills,
      onAddBill: openAddBill,
      onBillTap: openBill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BillBuddy',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor:
        AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        backgroundColor: AppColors.background,
        body: currentScreen(),
        bottomNavigationBar: BottomNav(
          currentIndex: currentIndex,
          onChanged: (int index) {
            if (index == 2) {
              openAddBill();
              return;
            }

            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}