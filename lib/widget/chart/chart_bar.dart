/// A single vertical bar used in a chart, sized relative to its available height.
///
/// The [ChartBar] is a lightweight, stateless widget that visualizes a single
/// value as a vertical fill. It expands to occupy available horizontal space
/// (wrapped in an `Expanded`) and uses a `FractionallySizedBox` with
/// [heightFactor] equal to [fill] to determine the filled portion of the bar.
///
/// Visual and layout details:
/// - `fill` is interpreted as the fraction of the available height that the
///   bar should occupy. Typical values are in the range `0.0` (empty) to
///   `1.0` (full height). Values outside this range will grow or shrink the
///   bar accordingly.
/// - A small horizontal padding (4 logical pixels) is applied on both sides to
///   separate adjacent bars.
/// - The bar has a rounded top edge only (vertical `BorderRadius` on the top),
///   giving a pill-like top with a flat bottom.
/// - Color selection adapts to platform brightness:
///   - In dark mode, it uses `Theme.of(context).colorScheme.secondary`.
///   - In light mode, it uses `Theme.of(context).colorScheme.primary` with
///     reduced opacity (65%).
///
/// Usage notes:
/// - Place the [ChartBar] inside a vertically constrained parent (for example,
///   inside a `Column` with a fixed height or inside a `SizedBox`) so that
///   the `FractionallySizedBox` can compute the appropriate height from the
///   available space.
/// - Typically used together with other [ChartBar] instances to form a bar
///   chart representation of a dataset.
///
/// Example:
/// ```dart
/// // inside a fixed-height container
/// ChartBar(fill: 0.75)
/// ```
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
