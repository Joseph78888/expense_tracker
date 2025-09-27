/// Expenses
///
/// A stateful widget that manages and displays a collection of user expenses.
/// This widget is responsible for:
/// - Holding an internal list of `Expense` objects.
/// - Presenting a modal bottom sheet to add a new expense.
/// - Rendering a summary/chart area and a scrollable list of expenses.
/// - Allowing items to be removed with a transient SnackBar that offers an
///   "Undo" action to restore the deleted entry.
///
/// Behavior and responsibilities:
/// - The widget maintains its own mutable list of expenses in state and uses
///   `setState` to trigger UI updates when items are added or removed.
/// - When the list is empty, a centered placeholder message prompts the user
///   to add expenses. When the list contains items, an `ExpensesList` widget
///   is used to render them.
/// - A `Chart` (or similar summary) receives the current expenses and is shown
///   above the list to give a quick overview of the data.
/// - Tapping the AppBar "+" action opens a modal bottom sheet (scroll
///   controlled) that is expected to contain a `NewExpense` form. The form
///   must call the provided `onAddExpense` callback with a new `Expense` to
///   add it to the list.
///
/// Public interactions / callbacks:
/// - The add-expense overlay is opened through a method that calls
///   `showModalBottomSheet(..., isScrollControlled: true, ...)` and passes a
///   callback to the `NewExpense` widget to receive the newly created
///   `Expense`.
/// - The removal path records the index of the removed item, removes it from
///   the list, and then shows a `SnackBar` (3s) with an "Undo" action. If the
///   user taps "Undo", the expense is re-inserted at its original index,
///   preserving order.
///
/// UX considerations:
/// - Existing SnackBars are cleared before showing a new one so messages do
///   not stack.
/// - The modal bottom sheet is scroll controlled to accommodate the on-screen
///   keyboard and larger content when adding a new expense.
///
/// Integration notes:
/// - `NewExpense` is expected to accept a callback of type `(Expense) -> void`
///   that will be used to add the created expense to this widget's state.
/// - `ExpensesList` should accept the current list of expenses and a removal
///   callback so individual list items can request deletion.
/// - `Chart` should accept the current expenses to compute and display a
///   summary or visualization.
///
/// Example usage:
/// - Place `Expenses()` in your widget tree (e.g., as the body of a Scaffold
///   for a single-screen app). Use the AppBar action to add expenses and tap
///   list items' delete controls to remove them (with optional undo).
///
/// Implementation details:
/// - Stateful behavior is encapsulated in the corresponding `_ExpensesState`,
///   which manages the `_registeredExpenses` list and the helper methods for
///   opening the add-expense overlay, adding an expense, and removing an
///   expense with undo support.
/// A stateful widget that manages and displays a collection of user
/// expenses. This widget is responsible for:
/// - Holding the list of registered expenses.
/// - Showing a modal bottom sheet to add a new expense.
/// - Rendering the list of expenses or a placeholder message when empty.
/// - Allowing removal of an expense with an option to undo via a SnackBar.
///
/// Usage:
/// - Place `Expenses()` inside your widget tree (usually as a page/screen).
/// - Tap the AppBar "+" action to open the add-expense modal.
/// - The add-expense form should call the provided callback to add an expense.
///
/// The visual layout:
/// - AppBar with title "Expense Tracker" and an action button to add an expense.
/// - Body contains a placeholder area for a summary/chart and an expandable
///   area that shows the list of expenses (or a "no expenses" message).
///
/// Notes:
/// - This widget uses an internal List<Expense> to track items and calls
///   setState(...) to trigger UI updates when items are added or removed.
/// - Deletions are accompanied by a SnackBar containing an "Undo" action that
///   reinserts the removed expense at its original index if requested.
///
/// _ExpensesState
///
/// Internal state for `Expenses` that encapsulates behavior and data:
///
/// Fields:
/// - `_registeredExpenses`:
///   The list of currently stored Expense objects. Initialized with a single
///   example expense so the UI has content during development. Replace or
///   initialize as needed for production.
///
/// Methods:
/// - `_openAddExpenseOverlay()`:
///   Opens a modal bottom sheet (isScrollControlled: true) to present the
///   `NewExpense` widget. The `NewExpense` widget is expected to call the
///   provided `onAddExpense` callback with a new `Expense` instance when the
///   user submits the form.
///
/// - `_addExpense(Expense expense)`:
///   Adds the given expense to `_registeredExpenses` and calls `setState` to
///   update the UI. This method is intended to be passed to the add-expense
///   form as the completion callback.
///
/// - `_removeExpense(Expense expense)`:
///   Removes the given expense from `_registeredExpenses`. Before removal the
///   method captures the expense's index so it can be restored if the user
///   taps "Undo" on the SnackBar. After removing the item it shows a SnackBar
///   with a 3-second duration and an "Undo" action that re-inserts the
///   expense at its original index when pressed. Existing SnackBars are cleared
///   before showing the new one to avoid stacking messages.
///
/// Widget build behavior:
/// - When `_registeredExpenses` is empty, the UI shows a centered text
///   prompting the user to add expenses.
/// - When the list contains items, it delegates rendering to `ExpensesList`,
///   passing the list and the `_removeExpense` callback so individual list
///   items can request removal.
/// - The body layout uses a Column with a placeholder Text for summary/chart
///   content and an Expanded area that hosts the list or placeholder message.
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // List of all registered expenses
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'title',
      amount: 99.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  /// Opens the modal bottom sheet to add a new expense
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  /// Adds a new expense to the list and updates the UI
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// remove Expense from the list and update the UI
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // show undo message when deleting an expense
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('expense deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // message that shown if no expense found
    Widget mainContent = const Center(
      child: Text('No Expenese found!. please add some.'),
    );

    /// check if there is a _registeredExpenses found
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
            tooltip: 'Add Expense',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for summary or chart
            Chart(expenses: _registeredExpenses),
            // List of expenses
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
