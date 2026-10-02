import 'package:budget_buddy/core/database/database_provider.dart';
import 'package:budget_buddy/features/accounts/data/drift_account_repository.dart';
import 'package:budget_buddy/features/accounts/domain/account.dart';
import 'package:budget_buddy/features/accounts/domain/account_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_providers.g.dart';

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) =>
    DriftAccountRepository(ref.watch(appDatabaseProvider));

@riverpod
Future<Account> defaultAccount(Ref ref) =>
    ref.watch(accountRepositoryProvider).getDefault();
