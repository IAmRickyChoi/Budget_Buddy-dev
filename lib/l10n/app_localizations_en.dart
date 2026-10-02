// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Budget Buddy';

  @override
  String get tabTransactions => 'Transactions';

  @override
  String get tabReports => 'Reports';

  @override
  String get tabBudgets => 'Budgets';

  @override
  String get tabSettings => 'Settings';

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get balance => 'Balance';

  @override
  String get amount => 'Amount';

  @override
  String get invalidAmount => 'Enter a valid amount';

  @override
  String get category => 'Category';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get date => 'Date';

  @override
  String get note => 'Note';

  @override
  String get save => 'Save';

  @override
  String get saveFailed => 'Couldn\'t save. Please try again.';

  @override
  String get noTransactions => 'No transactions this month';

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get transactionDeleted => 'Transaction deleted';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryCafe => 'Cafe';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryHousing => 'Housing';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryOther => 'Other';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryBonus => 'Bonus';
}
