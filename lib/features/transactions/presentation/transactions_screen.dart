import 'package:budget_buddy/core/l10n/l10n_extension.dart';
import 'package:budget_buddy/features/categories/presentation/category_display.dart';
import 'package:budget_buddy/features/transactions/data/transaction_providers.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:budget_buddy/features/transactions/presentation/transactions_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final month = ref.watch(selectedMonthProvider);
    final items = ref.watch(monthTransactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabTransactions),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: l10n.previousMonth,
                icon: const Icon(Icons.chevron_left),
                onPressed: ref.read(selectedMonthProvider.notifier).previous,
              ),
              Text(
                DateFormat.yMMMM(locale).format(month),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                tooltip: l10n.nextMonth,
                icon: const Icon(Icons.chevron_right),
                onPressed: ref.read(selectedMonthProvider.notifier).next,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const _MonthlySummary(),
          const Divider(height: 1),
          Expanded(
            child: switch (items) {
              AsyncData(value: final list) when list.isEmpty => Center(
                child: Text(l10n.noTransactions),
              ),
              AsyncData(value: final list) => _TransactionList(items: list),
              AsyncError(:final error) => Center(child: Text('$error')),
              _ => const Center(child: CircularProgressIndicator()),
            },
          ),
        ],
      ),
    );
  }
}

class _MonthlySummary extends ConsumerWidget {
  const _MonthlySummary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final totals = ref.watch(monthlyTotalsProvider).value ?? const [];
    if (totals.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (final total in totals)
            Row(
              children: [
                _SummaryCell(
                  label: l10n.income,
                  value: total.income.format(locale),
                ),
                _SummaryCell(
                  label: l10n.expense,
                  value: total.expense.format(locale),
                ),
                _SummaryCell(
                  label: l10n.balance,
                  value: total.balance.format(locale),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  const _SummaryCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
          Text(label, style: textTheme.labelMedium),
          const SizedBox(height: 4),
          FittedBox(child: Text(value, style: textTheme.titleMedium)),
        ],
      ),
    );
  }
}

class _TransactionList extends ConsumerWidget {
  const _TransactionList({required this.items});

  final List<TransactionListItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final colors = Theme.of(context).colorScheme;

    // 날짜가 바뀌는 지점마다 날짜 헤더를 끼워 넣는다.
    final children = <Widget>[];
    DateTime? currentDay;
    for (final (:transaction, :category) in items) {
      if (transaction.occurredOn != currentDay) {
        currentDay = transaction.occurredOn;
        children.add(
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 4),
            child: Text(
              DateFormat.MMMEd(locale).format(currentDay),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        );
      }

      final isIncome = transaction.type == TransactionType.income;
      final amount = isIncome ? transaction.amount : -transaction.amount;
      final title = category?.label(l10n) ?? l10n.uncategorized;

      children.add(
        Dismissible(
          key: ValueKey(transaction.id),
          direction: DismissDirection.endToStart,
          background: ColoredBox(
            color: colors.errorContainer,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 24),
                child: Icon(Icons.delete, color: colors.onErrorContainer),
              ),
            ),
          ),
          onDismissed: (_) => _delete(context, ref, transaction),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(category?.icon ?? Icons.label_outline),
            ),
            title: Text(title),
            subtitle: transaction.note.isEmpty ? null : Text(transaction.note),
            trailing: Text(
              amount.format(locale),
              style: TextStyle(
                color: isIncome ? colors.primary : colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: children,
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Transaction transaction,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final message = context.l10n.transactionDeleted;
    await ref.read(transactionRepositoryProvider).delete(transaction.id);
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }
}
