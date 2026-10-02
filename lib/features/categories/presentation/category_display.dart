import 'package:budget_buddy/features/categories/domain/category.dart';
import 'package:budget_buddy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension CategoryDisplay on Category {
  /// 기본 카테고리는 키를 번역하고, 사용자가 만든 카테고리는 이름을 그대로.
  String label(AppLocalizations l10n) => switch (systemKey) {
    'food' => l10n.categoryFood,
    'cafe' => l10n.categoryCafe,
    'transport' => l10n.categoryTransport,
    'shopping' => l10n.categoryShopping,
    'housing' => l10n.categoryHousing,
    'health' => l10n.categoryHealth,
    'entertainment' => l10n.categoryEntertainment,
    'other_expense' || 'other_income' => l10n.categoryOther,
    'salary' => l10n.categorySalary,
    'bonus' => l10n.categoryBonus,
    _ => name ?? '',
  };

  IconData get icon => switch (systemKey) {
    'food' => Icons.restaurant,
    'cafe' => Icons.local_cafe,
    'transport' => Icons.directions_bus,
    'shopping' => Icons.shopping_bag,
    'housing' => Icons.home,
    'health' => Icons.local_hospital,
    'entertainment' => Icons.movie,
    'salary' => Icons.payments,
    'bonus' => Icons.card_giftcard,
    _ => Icons.label,
  };
}
