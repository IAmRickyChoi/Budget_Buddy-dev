import 'package:budget_buddy/core/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabTransactions)),
      body: Center(child: Text(l10n.comingSoon)),
    );
  }
}
