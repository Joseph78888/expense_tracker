/// A stateless widget that displays a scrollable list of [Expense] objects.
///
/// Each expense is rendered using [ExpensesItem] inside a [ListView.builder].
/// Items are wrapped in a [Dismissible] to enable swipe-to-delete behavior;
/// when an item is dismissed, [onRemoveExpense] is invoked with the dismissed
/// [Expense].
///
/// Important details:
/// - The Dismissible key is created via `ValueKey(expense)`. Ensure each
///   expense has a stable identity (e.g. unique id or proper equality/hashCode)
///   to avoid unexpected widget reuse or animation issues.
/// - This widget does not modify the provided [expenses] list. The parent
///   widget is responsible for removing the expense from its state when
///   [onRemoveExpense] is called.
/// - Using [ListView.builder] makes this suitable for long lists.
///
/// Parameters:
/// - [expenses]: The list of expenses to display. Must not be null.
/// - [onRemoveExpense]: Callback invoked when the user dismisses an expense.
///   The parent should handle removing the expense from its data source and
///   optionally provide undo logic.
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_item.dart';

/// Widget that displays a scrollable list of expenses
class ExpensesList extends StatelessWidget {
  /// List of expenses to display
  final List<Expense> expenses;
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
