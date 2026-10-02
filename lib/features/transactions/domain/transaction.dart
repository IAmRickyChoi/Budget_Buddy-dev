import 'package:budget_buddy/core/money/money.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String accountId,
    required TransactionType type,

    /// 항상 양수. 수입/지출은 [type]으로 구분한다.
    required Money amount,

    /// 날짜만 의미가 있다 (시·분은 0).
    required DateTime occurredOn,
    String? categoryId,
    @Default('') String note,
  }) = _Transaction;
}

/// 새 거래를 만들 때 화면이 넘기는 값. id와 시각은 Repository가 채운다.
@freezed
abstract class NewTransaction with _$NewTransaction {
  const factory NewTransaction({
    required String accountId,
    required TransactionType type,
    required Money amount,
    required DateTime occurredOn,
    String? categoryId,
    @Default('') String note,
  }) = _NewTransaction;
}

/// 한 달 동안 통화별 수입·지출 합계.
@freezed
abstract class MonthlyTotal with _$MonthlyTotal {
  const factory MonthlyTotal({required Money income, required Money expense}) =
      _MonthlyTotal;

  const MonthlyTotal._();

  Money get balance => income - expense;
}
