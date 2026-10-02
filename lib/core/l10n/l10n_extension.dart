import 'package:budget_buddy/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension L10nX on BuildContext {
  /// `AppLocalizations.of(context)` 대신 `context.l10n`으로 짧게 쓴다.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
