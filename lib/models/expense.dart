/// Library: Expense model and utilities
///
/// Provides the core data model and small helpers used by the expense tracker:
/// - A lightweight `Expense` class representing a single expense entry.
/// - A `Category` enum for classifying expenses.
/// - A map of category icons for UI representation.
/// - A UUID generator and date formatter used when creating and displaying expenses.
///
/// This file has no side effects and contains only pure data definitions and
/// presentation helpers (icon mapping and date formatting).
///
/// Typical usage:
/// ```dart
/// final e = Expense(
///   title: 'Lunch',
///   amount: 12.50,
///   date: DateTime.now(),
///   category: Category.food,
/// );
/// print(e.formattedDate);
/// ```

/// Unique identifier generator used to assign a stable, random `id` to each
/// `Expense` instance. Implemented via the `package:uuid` package.
///
/// The generator is intended to be shared across the module so that each
/// created `Expense` receives a globally unique id via `uuid.v4()`.

/// Date formatter configured to produce a locale-aware short date string
/// (equivalent to `DateFormat.yMd()` from `package:intl`).
///
/// This formatter is reused for presenting expense dates consistently across
/// the UI and avoids allocating a new formatter for every instance.

/// Expense categories for classification.
///
/// - Category.food: Food and dining related expenses.
/// - Category.travel: Transportation, flights and related travel costs.
/// - Category.leisure: Entertainment and leisure activities.
/// - Category.work: Work-related purchases and business expenses.

/// Maps each `Category` value to a representative `IconData` value used by
/// the UI when rendering category badges, list tiles, or filters.
///
/// The map is intended for lookups in presentation code and keeps icon choices
/// centralized so they can be adjusted without changing UI widgets.

/// Model representing a single expense entry.
///
/// An `Expense` captures the key pieces of information required by the app:
/// a stable unique identifier, a human-readable title, a monetary amount,
/// the date when the expense occurred, and a `Category` used for grouping and
/// filtering.
///
/// Instances are immutable after construction; the `id` is generated
/// automatically using a UUID to ensure uniqueness across creations.

/// Creates a new [Expense].
///
/// Parameters:
/// - [title]: A short, human-readable description of the expense (required).
/// - [amount]: The monetary amount for the expense (required).
/// - [date]: The `DateTime` the expense occurred (required).
/// - [category]: The category used to classify the expense (required).
///
/// The [id] is generated internally via the shared UUID generator and is not
/// passed in by callers. Validation (e.g. non-negative amounts) is the
/// responsibility of the caller or higher-level logic.

/// Unique identifier for this expense.
///
/// Generated automatically when the instance is created. Intended to be stable
/// for as long as the expense is persisted (e.g. saved to a database or file).

/// Human-readable title or description of the expense.
///
/// Should be concise and suitable for display in lists and summary views.

/// Monetary amount of the expense.
///
/// Represented as a `double`. Consumers should format this value for display
/// according to locale and currency conventions when presenting it to users.

/// Date when the expense occurred.
///
/// Used for sorting, grouping by day/week/month, and for display with
/// [formattedDate].

/// Category used to classify the expense.
///
/// Enables filtering and grouping in UI components and determines the icon
/// provided by the shared `categoryIcons` map.

/// Returns a locale-formatted short date string for display purposes.
///
/// Uses the shared `formatter` instance (`DateFormat.yMd()`), ensuring a
/// consistent date representation across the app.
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); // unique id generator
final formatter = DateFormat.yMd(); // date formatter

// Expense categories for classification
enum Category { food, travel, leisure, work }

// Maps each category to a representative icon
const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

/// Expense model representing a single expense entry
class Expense {
  /// Creates an Expense with a unique id
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id; // Unique identifier
  final String title; // Expense title/description
  final double amount; // Expense amount
  final DateTime date; // Date of the expense
  final Category category; // Category of the expense

  /// Returns the formatted date string for display
  String get formattedDate => formatter.format(date);
}
