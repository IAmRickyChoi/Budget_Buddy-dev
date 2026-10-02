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

  @override
  String get expense => '支出';

  @override
  String get income => '収入';

  @override
  String get balance => '収支';

  @override
  String get amount => '金額';

  @override
  String get invalidAmount => '正しい金額を入力してください';

  @override
  String get category => 'カテゴリ';

  @override
  String get uncategorized => '未分類';

  @override
  String get date => '日付';

  @override
  String get note => 'メモ';

  @override
  String get save => '保存';

  @override
  String get saveFailed => '保存できませんでした。もう一度お試しください。';

  @override
  String get noTransactions => '今月の取引はありません';

  @override
  String get previousMonth => '前の月';

  @override
  String get nextMonth => '次の月';

  @override
  String get transactionDeleted => '削除しました';

  @override
  String get categoryFood => '食費';

  @override
  String get categoryCafe => 'カフェ';

  @override
  String get categoryTransport => '交通';

  @override
  String get categoryShopping => '買い物';

  @override
  String get categoryHousing => '住居';

  @override
  String get categoryHealth => '医療';

  @override
  String get categoryEntertainment => '娯楽';

  @override
  String get categoryOther => 'その他';

  @override
  String get categorySalary => '給与';

  @override
  String get categoryBonus => 'ボーナス';
}
