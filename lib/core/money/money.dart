import 'package:budget_buddy/core/money/currency.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// 금액과 통화를 항상 함께 들고 다니는 값 객체.
///
/// 금액은 `double`이 아니라 통화의 최소 단위 정수로 저장한다.
/// (예: $12.34 → 1234, ₩12,000 → 12000)
/// `double`은 0.1 + 0.2 != 0.3 같은 오차가 있어서 돈 계산에 쓰면 안 된다.
@immutable
class Money implements Comparable<Money> {
  const Money(this.amountMinor, this.currencyCode);

  const Money.zero(this.currencyCode) : amountMinor = 0;

  /// 사용자가 입력한 문자열("12.34", "12,34", "12000")을 최소 단위로 바꾼다.
  ///
  /// 문자열을 그대로 잘라서 계산하므로 부동소수점을 거치지 않는다.
  /// 통화의 소수 자릿수보다 길게 입력하거나, 0 이하이거나, 형식이 틀리면
  /// null을 돌려준다.
  static Money? tryParse(String input, String currencyCode) {
    final digits = Currency.fractionDigits(currencyCode);
    final normalized = input.trim().replaceAll(',', '.');
    final match = _amountPattern.firstMatch(normalized);
    if (match == null) return null;

    final whole = match.group(1) ?? '';
    final fraction = match.group(2) ?? '';
    if (whole.isEmpty && fraction.isEmpty) return null;
    if (fraction.length > digits) return null;
    // int 범위를 넘지 않도록 자릿수를 제한한다 (조 단위까지 충분).
    if (whole.length > 15) return null;

    final amount =
        int.parse(whole.isEmpty ? '0' : whole) * _pow10(digits) +
        int.parse(fraction.padRight(digits, '0').ifEmpty('0'));
    if (amount <= 0) return null;
    return Money(amount, currencyCode);
  }

  static final _amountPattern = RegExp(r'^(\d*)(?:\.(\d*))?$');

  final int amountMinor;
  final String currencyCode;

  int get fractionDigits => Currency.fractionDigits(currencyCode);

  Money operator +(Money other) {
    _checkSameCurrency(other);
    return Money(amountMinor + other.amountMinor, currencyCode);
  }

  Money operator -(Money other) {
    _checkSameCurrency(other);
    return Money(amountMinor - other.amountMinor, currencyCode);
  }

  Money operator -() => Money(-amountMinor, currencyCode);

  /// 화면 표시용 문자열. 로케일에 맞는 기호·구분자를 쓴다.
  /// (en_US: $1,234.50 / de_DE: 1.234,50 $ / ko_KR: ₩12,000)
  String format(String locale) {
    final formatter = NumberFormat.simpleCurrency(
      locale: locale,
      name: currencyCode,
      decimalDigits: fractionDigits,
    );
    // 표시할 때만 실수로 바꾼다. 계산은 항상 정수로 한다.
    return formatter.format(amountMinor / _pow10(fractionDigits));
  }

  void _checkSameCurrency(Money other) {
    if (other.currencyCode != currencyCode) {
      throw ArgumentError(
        'Cannot combine $currencyCode with ${other.currencyCode}',
      );
    }
  }

  @override
  int compareTo(Money other) {
    _checkSameCurrency(other);
    return amountMinor.compareTo(other.amountMinor);
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.amountMinor == amountMinor &&
      other.currencyCode == currencyCode;

  @override
  int get hashCode => Object.hash(amountMinor, currencyCode);

  @override
  String toString() => 'Money($amountMinor $currencyCode)';
}

int _pow10(int exponent) {
  var result = 1;
  for (var i = 0; i < exponent; i++) {
    result *= 10;
  }
  return result;
}

extension on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}
