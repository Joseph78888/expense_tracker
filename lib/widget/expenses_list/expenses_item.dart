/// A stateless widget that displays a single [Expense] inside a styled `Card`.
///
/// The widget renders:
/// - The expense title (bold, white).
/// - The expense amount formatted to two decimal places and prefixed with `$`.
/// - An icon representing the expense category (looked up from `categoryIcons`).
/// - The formatted date from `expense.formattedDate`.
///
/// Visual and layout details:
/// - Uses a `Card` with `Colors.blueAccent`.
/// - Content is padded symmetrically (horizontal: 20, vertical: 16).
/// - Title is placed above a row that contains the amount on the left and the
///   category icon + date aligned to the right.
///
/// Parameters:
/// - [expense]: The [Expense] model to display. Its `title`, `amount`,
///   `category`, and `formattedDate` fields are used.
///
/// Notes:
/// - The widget is immutable and extends `StatelessWidget`.
/// - It relies on a `categoryIcons` map being available in scope that maps the
///   expense category to an `IconData`.
/// - The amount is displayed with two decimal places via `toStringAsFixed(2)`.
///
/// Example:
/// ```dart
/// ExpensesItem(expense);
/// ```
///
/// Accessibility:
/// - Consider adding semantic labels or additional accessibility attributes
///   if required by your app. This widget focuses on visual presentation only.
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
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
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
