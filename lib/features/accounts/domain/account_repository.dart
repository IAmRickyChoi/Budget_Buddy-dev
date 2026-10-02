import 'package:budget_buddy/features/accounts/domain/account.dart';

abstract interface class AccountRepository {
  /// 지금은 계좌가 하나라서 첫 번째 계좌를 쓴다.
  Future<Account> getDefault();
}
