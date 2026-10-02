/// ISO 4217 통화별 소수 자릿수.
///
/// 대부분의 통화는 소수 둘째 자리(센트)까지 쓰지만, 원·엔처럼 소수가 없는
/// 통화와 디나르처럼 셋째 자리까지 쓰는 통화가 있다. 표에 없으면 2로 본다.
abstract final class Currency {
  static const _fractionDigits = <String, int>{
    'KRW': 0,
    'JPY': 0,
    'VND': 0,
    'CLP': 0,
    'ISK': 0,
    'PYG': 0,
    'UGX': 0,
    'BHD': 3,
    'IQD': 3,
    'JOD': 3,
    'KWD': 3,
    'LYD': 3,
    'OMR': 3,
    'TND': 3,
  };

  static int fractionDigits(String currencyCode) =>
      _fractionDigits[currencyCode.toUpperCase()] ?? 2;
}
