import 'package:budget_buddy/core/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

/// 테스트마다 새로 만드는 인메모리 DB. 기본 계좌·카테고리가 시드된다.
AppDatabase createTestDatabase({String currencyCode = 'USD'}) {
  // 위젯 테스트가 같은 DB 클래스를 여러 번 열어도 경고하지 않게 한다.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase(
    executor: NativeDatabase.memory(),
    defaultCurrencyCode: currencyCode,
  );
}
