import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_item.dart';

/// Widget that displays a scrollable list of expenses
class ExpensesList extends StatelessWidget {
  /// List of expenses to display
  final List<Expense> expenses;
  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpensesItem(expenses[index]),
    );
  }
}
