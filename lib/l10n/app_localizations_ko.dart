// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Budget Buddy';

  @override
  String get tabTransactions => '내역';

  @override
  String get tabReports => '통계';

  @override
  String get tabBudgets => '예산';

  @override
  String get tabSettings => '설정';

  @override
  String get addTransaction => '거래 추가';

  @override
  String get comingSoon => '준비 중이에요';
}
