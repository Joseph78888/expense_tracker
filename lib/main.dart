/// Entry point for the Expense Tracker application.
///
/// This file defines `main()` which boots a [MaterialApp] configured as the
/// root of the widget tree:
///
/// - Applies a custom [ThemeData] (currently setting `appBarTheme`).
/// - Hides the debug banner by setting `debugShowCheckedModeBanner` to `false`.
/// - Uses the `Expenses` widget (from `package:expense_tracker/widget/expenses.dart`)
///   as the application's `home` screen.
///
/// Notes:
/// - `Expenses` is the main screen / home route for the app and is expected to
///   provide the primary UI for creating, listing, and managing expenses.
/// - Ensure the `appBarTheme` value is provided as an `AppBarTheme` object rather
///   than a raw `Color` (e.g. `ThemeData(appBarTheme: AppBarTheme(color: ...) )`)
///   to avoid type errors.
/// - This file is intended to be the one and only entry point called by the
///   Flutter engine; any necessary initialization for plugins or services should
///   be performed here prior to calling `runApp`.
///
/// Usage:
/// - Run the app with `flutter run` or through your IDE; `main()` will construct
///   and inflate the widget tree starting from the `MaterialApp`.
import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';

// Entry point of the Expense Tracker app

void main() {
  // Run the app with Expenses as the home screen
  runApp(
    MaterialApp(
      theme: ThemeData(appBarTheme: Colors.black12),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Expenses(),
    ),
  );
}
