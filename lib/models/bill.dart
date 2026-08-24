class Bill {
  final String id;
  final String name;
  final String category;
  final double amount;
  final DateTime dueDate;
  final bool recurring;
  final bool paid;
  final String? notes;

  const Bill({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.dueDate,
    required this.recurring,
    required this.paid,
    this.notes,
  });

  bool get isOverdue {
    return !paid && dueDate.isBefore(DateTime.now());
  }

  bool get isUpcoming {
    if (paid) return false;

    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    return difference >= 0 && difference <= 7;
  }
}