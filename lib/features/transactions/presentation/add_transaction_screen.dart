import 'package:budget_buddy/core/l10n/l10n_extension.dart';
import 'package:budget_buddy/core/money/money.dart';
import 'package:budget_buddy/features/accounts/data/account_providers.dart';
import 'package:budget_buddy/features/accounts/domain/account.dart';
import 'package:budget_buddy/features/categories/data/category_providers.dart';
import 'package:budget_buddy/features/categories/presentation/category_display.dart';
import 'package:budget_buddy/features/transactions/domain/transaction.dart';
import 'package:budget_buddy/features/transactions/domain/transaction_type.dart';
import 'package:budget_buddy/features/transactions/presentation/add_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddTransactionScreen extends ConsumerWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(defaultAccountProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.addTransaction)),
      body: switch (account) {
        AsyncData(:final value) => _AddTransactionForm(account: value),
        AsyncError(:final error) => Center(child: Text('$error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _AddTransactionForm extends ConsumerStatefulWidget {
  const _AddTransactionForm({required this.account});

  final Account account;

  @override
  ConsumerState<_AddTransactionForm> createState() =>
      _AddTransactionFormState();
}

class _AddTransactionFormState extends ConsumerState<_AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _type = TransactionType.expense;
  String? _categoryId;
  DateTime _date = DateUtils.dateOnly(DateTime.now());

  String get _currency => widget.account.currencyCode;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final input = NewTransaction(
      accountId: widget.account.id,
      type: _type,
      amount: Money.tryParse(_amountController.text, _currency)!,
      occurredOn: _date,
      categoryId: _categoryId,
      note: _noteController.text,
    );
    final saved = await ref
        .read(addTransactionControllerProvider.notifier)
        .submit(input);
    if (saved && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final saveState = ref.watch(addTransactionControllerProvider);
    final categories = (ref.watch(categoriesProvider).value ?? const [])
        .where((c) => c.type == _type)
        .toList();
    final digits = Money(0, _currency).fractionDigits;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<TransactionType>(
            segments: [
              ButtonSegment(
                value: TransactionType.expense,
                label: Text(l10n.expense),
              ),
              ButtonSegment(
                value: TransactionType.income,
                label: Text(l10n.income),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (selection) => setState(() {
              _type = selection.first;
              // 지출 카테고리를 고른 채 수입으로 바꾸면 선택을 지운다.
              _categoryId = null;
            }),
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('amountField'),
            controller: _amountController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: l10n.amount,
              suffixText: _currency,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: digits > 0),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(digits > 0 ? '[0-9.,]' : '[0-9]'),
              ),
            ],
            validator: (text) => Money.tryParse(text ?? '', _currency) == null
                ? l10n.invalidAmount
                : null,
          ),
          const SizedBox(height: 16),
          Text(l10n.category, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in categories)
                ChoiceChip(
                  avatar: Icon(category.icon, size: 18),
                  label: Text(category.label(l10n)),
                  selected: _categoryId == category.id,
                  onSelected: (selected) => setState(
                    () => _categoryId = selected ? category.id : null,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(l10n.date),
            trailing: Text(DateFormat.yMMMEd(locale).format(_date)),
            onTap: _pickDate,
          ),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: l10n.note,
              border: const OutlineInputBorder(),
            ),
            maxLength: 100,
          ),
          if (saveState case AsyncError())
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.saveFailed,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          FilledButton(
            onPressed: saveState.isLoading ? null : _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
