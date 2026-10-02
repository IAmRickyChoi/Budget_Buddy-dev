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

  @override
  String get expense => '지출';

  @override
  String get income => '수입';

  @override
  String get balance => '합계';

  @override
  String get amount => '금액';

  @override
  String get invalidAmount => '올바른 금액을 입력하세요';

  @override
  String get category => '카테고리';

  @override
  String get uncategorized => '미분류';

  @override
  String get date => '날짜';

  @override
  String get note => '메모';

  @override
  String get save => '저장';

  @override
  String get saveFailed => '저장하지 못했어요. 다시 시도해 주세요.';

  @override
  String get noTransactions => '이번 달 내역이 없어요';

  @override
  String get previousMonth => '이전 달';

  @override
  String get nextMonth => '다음 달';

  @override
  String get transactionDeleted => '삭제했어요';

  @override
  String get categoryFood => '식비';

  @override
  String get categoryCafe => '카페';

  @override
  String get categoryTransport => '교통';

  @override
  String get categoryShopping => '쇼핑';

  @override
  String get categoryHousing => '주거';

  @override
  String get categoryHealth => '의료';

  @override
  String get categoryEntertainment => '여가';

  @override
  String get categoryOther => '기타';

  @override
  String get categorySalary => '급여';

  @override
  String get categoryBonus => '보너스';
}
