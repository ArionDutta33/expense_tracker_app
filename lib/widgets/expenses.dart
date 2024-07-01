import 'dart:math';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
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
      isScrollControlled: true,
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

  void _removeExpnese(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
      ),
    );
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
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemove: _removeExpnese,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(onPressed: _openOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: _registeredExpenses,
                ),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
