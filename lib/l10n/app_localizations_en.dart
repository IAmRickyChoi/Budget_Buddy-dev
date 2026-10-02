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
}
