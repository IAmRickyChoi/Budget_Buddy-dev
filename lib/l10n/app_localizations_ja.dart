// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Budget Buddy';

  @override
  String get tabTransactions => '履歴';

  @override
  String get tabReports => '統計';

  @override
  String get tabBudgets => '予算';

  @override
  String get tabSettings => '設定';

  @override
  String get addTransaction => '取引を追加';

  @override
  String get comingSoon => '準備中です';
}
