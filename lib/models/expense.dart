import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum CategoryList { leisure, work, food, travel }

const categoryIcons = {
  CategoryList.food: Icons.lunch_dining,
  CategoryList.travel: Icons.travel_explore,
  CategoryList.work: Icons.work,
  CategoryList.leisure: Icons.movie
};

class Expense {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final CategoryList category;
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final CategoryList category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
