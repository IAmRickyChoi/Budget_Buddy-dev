import 'package:budget_buddy/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Money.tryParse', () {
    test('converts to minor units without floating point', () {
      expect(Money.tryParse('12.34', 'USD'), const Money(1234, 'USD'));
      expect(Money.tryParse('0.1', 'USD'), const Money(10, 'USD'));
      expect(Money.tryParse('12', 'USD'), const Money(1200, 'USD'));
      expect(Money.tryParse('.5', 'USD'), const Money(50, 'USD'));
    });

    test('accepts a comma as the decimal separator', () {
      expect(Money.tryParse('12,34', 'EUR'), const Money(1234, 'EUR'));
    });

    test('respects the currency fraction digits', () {
      expect(Money.tryParse('12000', 'KRW'), const Money(12000, 'KRW'));
      expect(Money.tryParse('12.5', 'KRW'), isNull);
      expect(Money.tryParse('1.234', 'KWD'), const Money(1234, 'KWD'));
      expect(Money.tryParse('1.234', 'USD'), isNull);
    });

    test('rejects empty, zero and malformed input', () {
      for (final input in ['', '.', '0', '0.00', 'abc', '1.2.3', '-5']) {
        expect(Money.tryParse(input, 'USD'), isNull, reason: input);
      }
    });
  });

  group('arithmetic', () {
    test('adds and subtracts exactly', () {
      // double이면 0.1 + 0.2 = 0.30000000000000004
      final sum = const Money(10, 'USD') + const Money(20, 'USD');
      expect(sum, const Money(30, 'USD'));
      expect(sum - const Money(50, 'USD'), const Money(-20, 'USD'));
    });

    test('refuses to mix currencies', () {
      expect(
        () => const Money(100, 'USD') + const Money(100, 'KRW'),
        throwsArgumentError,
      );
    });
  });

  group('format', () {
    test('uses locale symbols and separators', () {
      expect(const Money(123450, 'USD').format('en_US'), r'$1,234.50');
      expect(const Money(12000, 'KRW').format('ko_KR'), '₩12,000');
      expect(const Money(500, 'JPY').format('ja_JP'), '¥500');
    });
  });
}
