
# Expense Tracker (Flutter)

A simple, modern Flutter app for tracking personal expenses. Add, view, and manage your expenses with a clean UI and Material 4 design.

## Features
- Add new expenses with title, amount, date, and category
- View expenses in a scrollable list
- Delete expenses with undo (SnackBar)
- Category icons and color-coded cards
- Responsive modal bottom sheet for adding expenses
- Summary chart (placeholder for future analytics)
- Modern Material 4 theming (light/dark)

## Getting Started

1. **Clone the repository**
   ```sh
   git clone https://github.com/Joseph78888/expense_tracker.git
   cd expense_tracker
   ```
2. **Install dependencies**
   ```sh
   flutter pub get
   ```
3. **Run the app**
   ```sh
   flutter run
   ```
   You can run on Android, iOS, web, Windows, macOS, or Linux (see Flutter docs for setup).

## Project Structure
```
lib/
  main.dart                # App entry point, theming, root widget
  models/expense.dart      # Expense model, category enum, icon mapping
  widget/
    expenses.dart          # Main screen, expense list, add/remove logic
    new_expense.dart       # Modal form for adding expenses
    expenses_list/
      expenses_list.dart   # Scrollable list of expenses (Dismissible)
      expenses_item.dart   # Card widget for a single expense
    chart/                 # (Optional) Chart widget for summary/analytics
```

## Usage
- Tap the "+" button in the AppBar to add a new expense.
- Fill out the form and tap "Save Expense".
- Swipe left/right on an expense to delete it (with undo option).
- View your expenses grouped by category and date.

## Dependencies
- [Flutter](https://flutter.dev/) (SDK >= 3.9.0)
- [uuid](https://pub.dev/packages/uuid) for unique expense IDs
- [intl](https://pub.dev/packages/intl) for date formatting

## Customization & Extending
- Add more categories or icons in `models/expense.dart`
- Implement charts/analytics in `widget/chart/`
- Add persistent storage (e.g. SQLite, Hive) for saving expenses
- Improve UI/UX with animations, filters, or search

## Development & Contributing
- Code style: Follows recommended Flutter lints
- To contribute: Fork, create a feature branch, open a PR
- Please include clear commit messages and test your changes

## License
MIT (or specify in LICENSE.md)

---
For questions or suggestions, open an issue or discussion on GitHub.