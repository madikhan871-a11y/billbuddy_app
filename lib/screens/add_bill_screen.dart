import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/bill.dart';
import '../models/bill_category.dart';

class AddBillScreen extends StatefulWidget {
  final ValueChanged<Bill> onSave;

  const AddBillScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<AddBillScreen> createState() =>
      _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  String category = 'Electricity';
  DateTime dueDate = DateTime.now().add(
    const Duration(days: 7),
  );
  bool recurring = true;

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (selected != null) {
      setState(() {
        dueDate = selected;
      });
    }
  }

  void save() {
    final name = nameController.text.trim();
    final amount = double.tryParse(
      amountController.text.trim(),
    );

    if (name.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter bill name and valid amount.',
          ),
        ),
      );
      return;
    }

    final bill = Bill(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      name: name,
      category: category,
      amount: amount,
      dueDate: dueDate,
      recurring: recurring,
      paid: false,
      notes: notesController.text.trim(),
    );

    widget.onSave(bill);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Add new bill',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.text,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          5,
          18,
          30,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            _Label(
              text: 'Bill name',
            ),
            _Input(
              controller: nameController,
              hint: 'e.g. LESCO Electricity',
              icon: Icons.receipt_long_outlined,
            ),

            const SizedBox(height: 15),

            _Label(
              text: 'Amount',
            ),
            _Input(
              controller: amountController,
              hint: 'e.g. 4850',
              icon: Icons.payments_outlined,
              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),

            const SizedBox(height: 15),

            _Label(
              text: 'Category',
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                BorderRadius.circular(17),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: category,
                  isExpanded: true,
                  items: BillCategory.all.map(
                        (item) {
                      return DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.text,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      category = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            _Label(
              text: 'Due date',
            ),

            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                  BorderRadius.circular(17),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.primary,
                      size: 19,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${dueDate.day}/${dueDate.month}/${dueDate.year}',
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.muted,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            _Label(
              text: 'Notes',
            ),
            _Input(
              controller: notesController,
              hint: 'Optional notes',
              icon: Icons.notes_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 10),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Repeat every month',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: const Text(
                'Create next month automatically',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 8,
                ),
              ),
              value: recurring,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() {
                  recurring = value;
                });
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
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
                child: const Text(
                  'Save bill',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
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

class _Label extends StatelessWidget {
  final String text;

  const _Label({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 7,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;

  const _Input({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 10,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.muted,
          fontSize: 9,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: 19,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}