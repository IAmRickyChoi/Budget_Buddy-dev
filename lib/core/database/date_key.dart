import 'package:intl/intl.dart';

/// DB에 날짜를 'yyyy-MM-dd' 문자열로 저장한다.
/// ISO 형식이라 문자열 비교(>=, <)가 날짜 비교와 같아서 범위 쿼리에 쓸 수 있다.
abstract final class DateKey {
  static final _format = DateFormat('yyyy-MM-dd');

  static String of(DateTime date) => _format.format(date);

  static DateTime parse(String key) => _format.parseStrict(key);

  /// [month]가 속한 달의 [시작, 다음 달 시작) 범위.
  static (String, String) monthRange(DateTime month) => (
    of(DateTime(month.year, month.month)),
    of(DateTime(month.year, month.month + 1)),
  );
}
