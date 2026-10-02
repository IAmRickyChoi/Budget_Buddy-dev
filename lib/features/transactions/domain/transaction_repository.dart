import 'package:budget_buddy/features/transactions/domain/transaction.dart';

abstract interface class TransactionRepository {
  /// [month]가 속한 달의 거래를 최신 날짜 순으로. DB가 바뀌면 다시 방출한다.
  Stream<List<Transaction>> watchMonth(DateTime month);

  /// [month]의 통화별 합계. 계좌가 여러 통화면 여러 개가 나온다.
  Stream<List<MonthlyTotal>> watchMonthlyTotals(DateTime month);

  Future<Transaction> add(NewTransaction input);

  /// 소프트 삭제. 동기화를 위해 행은 남기고 deletedAt만 채운다.
  Future<void> delete(String id);
}
