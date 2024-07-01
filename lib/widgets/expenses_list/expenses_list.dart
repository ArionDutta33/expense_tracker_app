import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  ExpensesList({super.key, required this.expenses, required this.onRemove});
  void Function(Expense expense) onRemove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onDismissed: (direction) {
            onRemove(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpensesItem(expense: expenses[index])),
    );
  }
}
