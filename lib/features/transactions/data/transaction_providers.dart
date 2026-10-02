import 'package:budget_buddy/core/database/database_provider.dart';
import 'package:budget_buddy/features/transactions/data/drift_transaction_repository.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_providers.g.dart';

/// 화면과 Notifier는 이 Provider로 인터페이스만 받는다.
/// 구현체(Drift)를 바꾸거나 테스트용 가짜로 갈아끼울 때 여기만 고치면 된다.
@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) =>
    DriftTransactionRepository(ref.watch(appDatabaseProvider));
