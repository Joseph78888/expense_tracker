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

final kLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF2D61FF), // bright indigo
);
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF9C7AFF), // soft purple for dark mode
  brightness: Brightness.dark,
);

void main() {
  runApp(
    MaterialApp(
      // Use modern Material 3 design and polished component styles
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkColorScheme.surfaceVariant,
          foregroundColor: kDarkColorScheme.onSurfaceVariant,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kDarkColorScheme.onSurfaceVariant,
          ),
        ),
        cardTheme: CardThemeData(
          color: kDarkColorScheme.surface,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kDarkColorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kDarkColorScheme.onSurface,
          ),
          bodyLarge: TextStyle(color: kDarkColorScheme.onSurface, fontSize: 16),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kLightColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kLightColorScheme.primaryContainer,
          foregroundColor: kLightColorScheme.onPrimaryContainer,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kLightColorScheme.onPrimaryContainer,
          ),
        ),
        cardTheme: CardThemeData(
          color: kLightColorScheme.surface,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLightColorScheme.primary,
            foregroundColor: kLightColorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kLightColorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kLightColorScheme.onSurface,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: kLightColorScheme.onSurface,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      themeMode: ThemeMode.system, // default
      home: Expenses(),
    ),
  );
}
