import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expesnse.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _openOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      title: "flutter course",
      amount: 19.9,
      category: CategoryList.work,
      date: DateTime.now(),
    ),
    Expense(
      title: "cinema",
      amount: 23.9,
      category: CategoryList.leisure,
      date: DateTime.now(),
    ),
    Expense(
      title: "chinese noodles",
      amount: 12.9,
      category: CategoryList.food,
      date: DateTime.now(),
    ),
    Expense(
      title: "python course",
      amount: 12.9,
      category: CategoryList.work,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () => _openOverlay(), icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
