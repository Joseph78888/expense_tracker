import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();

  @override
  void dispose() {
    titleControler.dispose();
    amountControler.dispose();
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
            controller: titleControler,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          // expense amount
          TextField(
            keyboardType: TextInputType.number,
            controller: amountControler,
            decoration: InputDecoration(
              prefixText: '\$ ',
              label: Text('amount'),
            ),
          ),
          Row(
            children: [
              Spacer(),
              // Cancel Expense Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              // Save Expense button
              ElevatedButton(
                onPressed: () {
                  print(titleControler.text);
                  print(amountControler.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
