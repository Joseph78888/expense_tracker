import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _SelectDate() async {
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

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // add new expense
          // expense title
          TextField(
            controller: _titleControler,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),

          Row(
            children: [
              Expanded(
                // expense amount
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountControler,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
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
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: _SelectDate,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (catrgory) => DropdownMenuItem(
                        value: catrgory,
                        child: Text(catrgory.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              // Cancel Expense Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              // Save Expense button
              ElevatedButton(onPressed: () {}, child: Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}
