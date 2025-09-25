import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

// Entry point of the Expense Tracker app

void main() {
  // Run the app with Expenses as the home screen
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Expenses(),
    ),
  );
}
