/// A modal bottom-sheet widget that provides a form for creating a new
/// Expense item.
///
/// The widget collects the following inputs from the user:
/// - Title: single-line text input (max length 50).
/// - Amount: numeric input (parsed to double, must be > 0).
/// - Date: selected via a date picker (allowed range: one year ago through today).
/// - Category: chosen from the available `Category.values`.
///
/// Validation:
/// - Title must be non-empty after trimming.
/// - Amount must be a valid number greater than zero.
/// - A date must be selected.
///
/// Behavior:
/// - On successful validation, constructs an [Expense] and invokes the
///   provided [onAddExpense] callback, then closes the modal (pops the route).
/// - On validation failure, shows an [AlertDialog] describing the required fields.
///
/// Typical usage:
/// - Present this widget inside `showModalBottomSheet` and provide an
///   `onAddExpense` callback to receive the created [Expense].
///
/// Parameters:
/// - [onAddExpense]: required callback invoked with the newly created [Expense].
///
/// Note:
/// - This widget manages `TextEditingController` instances and disposes them
///   in its `dispose` lifecycle method to avoid memory leaks.
///
/// See also:
/// - [Expense] (model used to construct the object passed to [onAddExpense]).
/// - [Category] (enumeration used to populate the category dropdown).
///
///
/// State internals (implementation notes)
/// --------------------------------------
/// The state object:
/// - Holds `_titleControler` and `_amountControler` for the text fields.
/// - Tracks `_selectedDate` (nullable) and `_selectedCategory`.
/// - Provides `_selectDate()` to show a constrained date picker and update state.
/// - Provides `_submitExpenceData()` which:
///   1. Parses and validates inputs.
///   2. Shows an error dialog on invalid input.
///   3. Calls `widget.onAddExpense(...)` with a validated [Expense] on success.
///   4. Closes the modal with `Navigator.pop`.
/// - Disposes controllers in `dispose()` to free resources.
///
/// Accessibility & UX:
/// - Date display updates to show the chosen date or a 'Select Date' prompt.
/// - Category dropdown displays categories using `category.name.toUpperCase()`.
/// - Action buttons include 'Cancel' (closes modal) and 'Save Expense' (attempts submit).
// Widget for adding a new expense via a modal bottom sheet
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  /// Callback to add a new expense to the parent list
  final void Function(Expense expense) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controllers for text fields
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  /// Opens a date picker and sets the selected date
  void _selectDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = datePicked;
    });
  }

  /// Validates and submits the new expense data
  void _submitExpenceData() {
    final enteredAmount = double.tryParse(_amountControler.text);
    final inValidAmount = enteredAmount == null || enteredAmount <= 0;

    if (_titleControler.text.trim().isEmpty ||
        inValidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleControler.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          // Expense title input
          TextField(
            controller: _titleControler,
            maxLength: 50,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          Row(
            children: [
              Expanded(
                // Expense amount input
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountControler,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    labelText: 'Amount',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : formatter.format(_selectedDate!),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: _selectDate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Category dropdown
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              // Cancel Expense Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              // Save Expense button
              ElevatedButton(
                onPressed: _submitExpenceData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
