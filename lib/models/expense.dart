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
