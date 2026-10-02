// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Transaction {

 String get id; String get accountId; TransactionType get type;/// 항상 양수. 수입/지출은 [type]으로 구분한다.
 Money get amount;/// 날짜만 의미가 있다 (시·분은 0).
 DateTime get occurredOn; String? get categoryId; String get note;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Transaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.occurredOn, _this.occurredOn) || other.occurredOn == _this.occurredOn)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as Transaction;
  return Object.hash(runtimeType,_this.id,_this.accountId,_this.type,_this.amount,_this.occurredOn,_this.categoryId,_this.note);
}

@override
String toString() {
  final _this = this as Transaction;
  return 'Transaction(id: ${_this.id}, accountId: ${_this.accountId}, type: ${_this.type}, amount: ${_this.amount}, occurredOn: ${_this.occurredOn}, categoryId: ${_this.categoryId}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, TransactionType type, Money amount, DateTime occurredOn, String? categoryId, String note
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? occurredOn = null,Object? categoryId = freezed,Object? note = null,}) {
  return _then(Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredOn: null == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Transaction implements Transaction {
  const _Transaction({required this.id, required this.accountId, required this.type, required this.amount, required this.occurredOn, this.categoryId, this.note = ''});
  

@override final  String id;
@override final  String accountId;
@override final  TransactionType type;
/// 항상 양수. 수입/지출은 [type]으로 구분한다.
@override final  Money amount;
/// 날짜만 의미가 있다 (시·분은 0).
@override final  DateTime occurredOn;
@override final  String? categoryId;
@override@JsonKey() final  String note;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.occurredOn, occurredOn) || other.occurredOn == occurredOn)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,accountId,type,amount,occurredOn,categoryId,note);
}

@override
String toString() {
    return 'Transaction(id: $id, accountId: $accountId, type: $type, amount: $amount, occurredOn: $occurredOn, categoryId: $categoryId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, TransactionType type, Money amount, DateTime occurredOn, String? categoryId, String note
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? occurredOn = null,Object? categoryId = freezed,Object? note = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredOn: null == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NewTransaction {

 String get accountId; TransactionType get type; Money get amount; DateTime get occurredOn; String? get categoryId; String get note;
/// Create a copy of NewTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewTransactionCopyWith<NewTransaction> get copyWith => _$NewTransactionCopyWithImpl<NewTransaction>(this as NewTransaction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NewTransaction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewTransaction&&(identical(other.accountId, _this.accountId) || other.accountId == _this.accountId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.occurredOn, _this.occurredOn) || other.occurredOn == _this.occurredOn)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as NewTransaction;
  return Object.hash(runtimeType,_this.accountId,_this.type,_this.amount,_this.occurredOn,_this.categoryId,_this.note);
}

@override
String toString() {
  final _this = this as NewTransaction;
  return 'NewTransaction(accountId: ${_this.accountId}, type: ${_this.type}, amount: ${_this.amount}, occurredOn: ${_this.occurredOn}, categoryId: ${_this.categoryId}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $NewTransactionCopyWith<$Res>  {
  factory $NewTransactionCopyWith(NewTransaction value, $Res Function(NewTransaction) _then) = _$NewTransactionCopyWithImpl;
@useResult
$Res call({
 String accountId, TransactionType type, Money amount, DateTime occurredOn, String? categoryId, String note
});




}
/// @nodoc
class _$NewTransactionCopyWithImpl<$Res>
    implements $NewTransactionCopyWith<$Res> {
  _$NewTransactionCopyWithImpl(this._self, this._then);

  final NewTransaction _self;
  final $Res Function(NewTransaction) _then;

/// Create a copy of NewTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? type = null,Object? amount = null,Object? occurredOn = null,Object? categoryId = freezed,Object? note = null,}) {
  return _then(NewTransaction(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredOn: null == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NewTransaction].
extension NewTransactionPatterns on NewTransaction {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewTransaction() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewTransaction value)  $default,){
final _that = this;
switch (_that) {
case _NewTransaction():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _NewTransaction() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewTransaction() when $default != null:
return $default(_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)  $default,) {final _that = this;
switch (_that) {
case _NewTransaction():
return $default(_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  TransactionType type,  Money amount,  DateTime occurredOn,  String? categoryId,  String note)?  $default,) {final _that = this;
switch (_that) {
case _NewTransaction() when $default != null:
return $default(_that.accountId,_that.type,_that.amount,_that.occurredOn,_that.categoryId,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _NewTransaction implements NewTransaction {
  const _NewTransaction({required this.accountId, required this.type, required this.amount, required this.occurredOn, this.categoryId, this.note = ''});
  

@override final  String accountId;
@override final  TransactionType type;
@override final  Money amount;
@override final  DateTime occurredOn;
@override final  String? categoryId;
@override@JsonKey() final  String note;

/// Create a copy of NewTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewTransactionCopyWith<_NewTransaction> get copyWith => __$NewTransactionCopyWithImpl<_NewTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewTransaction&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.occurredOn, occurredOn) || other.occurredOn == occurredOn)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,accountId,type,amount,occurredOn,categoryId,note);
}

@override
String toString() {
    return 'NewTransaction(accountId: $accountId, type: $type, amount: $amount, occurredOn: $occurredOn, categoryId: $categoryId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$NewTransactionCopyWith<$Res> implements $NewTransactionCopyWith<$Res> {
  factory _$NewTransactionCopyWith(_NewTransaction value, $Res Function(_NewTransaction) _then) = __$NewTransactionCopyWithImpl;
@override @useResult
$Res call({
 String accountId, TransactionType type, Money amount, DateTime occurredOn, String? categoryId, String note
});




}
/// @nodoc
class __$NewTransactionCopyWithImpl<$Res>
    implements _$NewTransactionCopyWith<$Res> {
  __$NewTransactionCopyWithImpl(this._self, this._then);

  final _NewTransaction _self;
  final $Res Function(_NewTransaction) _then;

/// Create a copy of NewTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? type = null,Object? amount = null,Object? occurredOn = null,Object? categoryId = freezed,Object? note = null,}) {
  return _then(_NewTransaction(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,occurredOn: null == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MonthlyTotal {

 Money get income; Money get expense;
/// Create a copy of MonthlyTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyTotalCopyWith<MonthlyTotal> get copyWith => _$MonthlyTotalCopyWithImpl<MonthlyTotal>(this as MonthlyTotal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MonthlyTotal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyTotal&&(identical(other.income, _this.income) || other.income == _this.income)&&(identical(other.expense, _this.expense) || other.expense == _this.expense));
}


@override
int get hashCode {
  final _this = this as MonthlyTotal;
  return Object.hash(runtimeType,_this.income,_this.expense);
}

@override
String toString() {
  final _this = this as MonthlyTotal;
  return 'MonthlyTotal(income: ${_this.income}, expense: ${_this.expense})';
}


}

/// @nodoc
abstract mixin class $MonthlyTotalCopyWith<$Res>  {
  factory $MonthlyTotalCopyWith(MonthlyTotal value, $Res Function(MonthlyTotal) _then) = _$MonthlyTotalCopyWithImpl;
@useResult
$Res call({
 Money income, Money expense
});




}
/// @nodoc
class _$MonthlyTotalCopyWithImpl<$Res>
    implements $MonthlyTotalCopyWith<$Res> {
  _$MonthlyTotalCopyWithImpl(this._self, this._then);

  final MonthlyTotal _self;
  final $Res Function(MonthlyTotal) _then;

/// Create a copy of MonthlyTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? income = null,Object? expense = null,}) {
  return _then(MonthlyTotal(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyTotal].
extension MonthlyTotalPatterns on MonthlyTotal {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyTotal() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyTotal value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyTotal():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyTotal value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyTotal() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Money income,  Money expense)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyTotal() when $default != null:
return $default(_that.income,_that.expense);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Money income,  Money expense)  $default,) {final _that = this;
switch (_that) {
case _MonthlyTotal():
return $default(_that.income,_that.expense);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Money income,  Money expense)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyTotal() when $default != null:
return $default(_that.income,_that.expense);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyTotal extends MonthlyTotal {
  const _MonthlyTotal({required this.income, required this.expense}): super._();
  

@override final  Money income;
@override final  Money expense;

/// Create a copy of MonthlyTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyTotalCopyWith<_MonthlyTotal> get copyWith => __$MonthlyTotalCopyWithImpl<_MonthlyTotal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyTotal&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode {
    return Object.hash(runtimeType,income,expense);
}

@override
String toString() {
    return 'MonthlyTotal(income: $income, expense: $expense)';
}


}

/// @nodoc
abstract mixin class _$MonthlyTotalCopyWith<$Res> implements $MonthlyTotalCopyWith<$Res> {
  factory _$MonthlyTotalCopyWith(_MonthlyTotal value, $Res Function(_MonthlyTotal) _then) = __$MonthlyTotalCopyWithImpl;
@override @useResult
$Res call({
 Money income, Money expense
});




}
/// @nodoc
class __$MonthlyTotalCopyWithImpl<$Res>
    implements _$MonthlyTotalCopyWith<$Res> {
  __$MonthlyTotalCopyWithImpl(this._self, this._then);

  final _MonthlyTotal _self;
  final $Res Function(_MonthlyTotal) _then;

/// Create a copy of MonthlyTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? income = null,Object? expense = null,}) {
  return _then(_MonthlyTotal(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as Money,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as Money,
  ));
}


}

// dart format on
