import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

/// Widget that displays a single expense item in a styled card
class ExpensesItem extends StatelessWidget {
  final Expense expense;
  const ExpensesItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expense title
            Text(
              expense.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Expense amount
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    // Category icon
                    Icon(
                      categoryIcons[expense.category],
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    // Expense date
                    Text(
                      expense.formattedDate,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
