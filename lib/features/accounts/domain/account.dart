import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    required String id,
    required String currencyCode,
    String? name,
    String? systemKey,
  }) = _Account;
}
