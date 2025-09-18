import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // list title
            Text(
              expense.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // list amount
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    // list icon
                    Icon(
                      categoryIcons[expense.category],
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    // list date
                    Text(
                      expense.formattedDate,
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
