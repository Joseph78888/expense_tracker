/// A visual summary widget that displays a simple vertical bar chart for a
/// collection of expenses grouped by category.
///
/// The Chart widget:
/// - Accepts a list of [Expense] objects via the `expenses` constructor
///   parameter.
/// - Computes four buckets (food, leisure, travel, work) using
///   `ExpenseBucket.forCategory(...)`. Each bucket aggregates expenses for a
///   single category and exposes a `totalExpenses` value used to size bars.
/// - Exposes a `buckets` getter that returns the list of category buckets in
///   the displayed order (food, leisure, travel, work).
/// - Exposes a `maxTotalExpense` getter that returns the largest total among
///   the buckets; this is used to normalize bar heights so the tallest bar is
///   full height (fill == 1.0). If a bucket has zero total, its fill is 0.
///
/// Visual & accessibility notes:
/// - The widget has a fixed height and fills available width. It renders a
///   slightly translucent vertical gradient background and rounded corners.
/// - The chart area contains a row of [ChartBar] widgets (one per bucket).
///   Each [ChartBar] receives a `fill` ratio in the range 0.0..1.0 computed as
///   `bucket.totalExpenses / maxTotalExpense` (or 0 when the bucket total is
///   zero).
/// - A second row renders icons for each category beneath the bars. Icon color
///   adapts to the platform brightness (dark mode uses `colorScheme.secondary`,
///   light mode uses a semi-opaque `colorScheme.primary`).
///
/// Usage:
/// - Instantiate with `Chart(expenses: myExpenses)`.
/// - The widget is stateless and recalculates buckets and maxima on each build
///   based on the provided `expenses` list.
///
/// Notes:
/// - This widget expects `categoryIcons` and `ExpenseBucket` to be defined
///   elsewhere in the codebase (imported from related modules).
/// - Keep the `expenses` list up-to-date (or provide a new list) to update the
///   chart; the widget itself does not mutate the list.
import 'package:flutter/material.dart';

import 'package:expense_tracker/widget/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
