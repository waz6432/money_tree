// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get passowrd => throw _privateConstructorUsedError;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String userName, String passowrd});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? passowrd = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      passowrd: null == passowrd
          ? _value.passowrd
          : passowrd // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginObjectImplCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$LoginObjectImplCopyWith(
          _$LoginObjectImpl value, $Res Function(_$LoginObjectImpl) then) =
      __$$LoginObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String passowrd});
}

/// @nodoc
class __$$LoginObjectImplCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$LoginObjectImpl>
    implements _$$LoginObjectImplCopyWith<$Res> {
  __$$LoginObjectImplCopyWithImpl(
      _$LoginObjectImpl _value, $Res Function(_$LoginObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? passowrd = null,
  }) {
    return _then(_$LoginObjectImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      passowrd: null == passowrd
          ? _value.passowrd
          : passowrd // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginObjectImpl implements _LoginObject {
  _$LoginObjectImpl({required this.userName, required this.passowrd});

  @override
  final String userName;
  @override
  final String passowrd;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, passowrd: $passowrd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginObjectImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.passowrd, passowrd) ||
                other.passowrd == passowrd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, passowrd);

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      __$$LoginObjectImplCopyWithImpl<_$LoginObjectImpl>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(
      {required final String userName,
      required final String passowrd}) = _$LoginObjectImpl;

  @override
  String get userName;
  @override
  String get passowrd;

  /// Create a copy of LoginObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginObjectImplCopyWith<_$LoginObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EmailObject {
  String get email => throw _privateConstructorUsedError;

  /// Create a copy of EmailObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailObjectCopyWith<EmailObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailObjectCopyWith<$Res> {
  factory $EmailObjectCopyWith(
          EmailObject value, $Res Function(EmailObject) then) =
      _$EmailObjectCopyWithImpl<$Res, EmailObject>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$EmailObjectCopyWithImpl<$Res, $Val extends EmailObject>
    implements $EmailObjectCopyWith<$Res> {
  _$EmailObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailObjectImplCopyWith<$Res>
    implements $EmailObjectCopyWith<$Res> {
  factory _$$EmailObjectImplCopyWith(
          _$EmailObjectImpl value, $Res Function(_$EmailObjectImpl) then) =
      __$$EmailObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailObjectImplCopyWithImpl<$Res>
    extends _$EmailObjectCopyWithImpl<$Res, _$EmailObjectImpl>
    implements _$$EmailObjectImplCopyWith<$Res> {
  __$$EmailObjectImplCopyWithImpl(
      _$EmailObjectImpl _value, $Res Function(_$EmailObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailObjectImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailObjectImpl implements _EmailObject {
  _$EmailObjectImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'EmailObject(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailObjectImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of EmailObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailObjectImplCopyWith<_$EmailObjectImpl> get copyWith =>
      __$$EmailObjectImplCopyWithImpl<_$EmailObjectImpl>(this, _$identity);
}

abstract class _EmailObject implements EmailObject {
  factory _EmailObject({required final String email}) = _$EmailObjectImpl;

  @override
  String get email;

  /// Create a copy of EmailObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailObjectImplCopyWith<_$EmailObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get countryMobileCode => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {String countryMobileCode,
      String userName,
      String email,
      String password,
      String mobileNumber,
      String profilePicture});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryMobileCode = null,
    Object? userName = null,
    Object? email = null,
    Object? password = null,
    Object? mobileNumber = null,
    Object? profilePicture = null,
  }) {
    return _then(_value.copyWith(
      countryMobileCode: null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterObjectImplCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$RegisterObjectImplCopyWith(_$RegisterObjectImpl value,
          $Res Function(_$RegisterObjectImpl) then) =
      __$$RegisterObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String countryMobileCode,
      String userName,
      String email,
      String password,
      String mobileNumber,
      String profilePicture});
}

/// @nodoc
class __$$RegisterObjectImplCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$RegisterObjectImpl>
    implements _$$RegisterObjectImplCopyWith<$Res> {
  __$$RegisterObjectImplCopyWithImpl(
      _$RegisterObjectImpl _value, $Res Function(_$RegisterObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryMobileCode = null,
    Object? userName = null,
    Object? email = null,
    Object? password = null,
    Object? mobileNumber = null,
    Object? profilePicture = null,
  }) {
    return _then(_$RegisterObjectImpl(
      countryMobileCode: null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterObjectImpl implements _RegisterObject {
  _$RegisterObjectImpl(
      {required this.countryMobileCode,
      required this.userName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.profilePicture});

  @override
  final String countryMobileCode;
  @override
  final String userName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String mobileNumber;
  @override
  final String profilePicture;

  @override
  String toString() {
    return 'RegisterObject(countryMobileCode: $countryMobileCode, userName: $userName, email: $email, password: $password, mobileNumber: $mobileNumber, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterObjectImpl &&
            (identical(other.countryMobileCode, countryMobileCode) ||
                other.countryMobileCode == countryMobileCode) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @override
  int get hashCode => Object.hash(runtimeType, countryMobileCode, userName,
      email, password, mobileNumber, profilePicture);

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      __$$RegisterObjectImplCopyWithImpl<_$RegisterObjectImpl>(
          this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      {required final String countryMobileCode,
      required final String userName,
      required final String email,
      required final String password,
      required final String mobileNumber,
      required final String profilePicture}) = _$RegisterObjectImpl;

  @override
  String get countryMobileCode;
  @override
  String get userName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get mobileNumber;
  @override
  String get profilePicture;

  /// Create a copy of RegisterObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterObjectImplCopyWith<_$RegisterObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NewTransactionObject {
  int get amount => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  /// Create a copy of NewTransactionObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewTransactionObjectCopyWith<NewTransactionObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTransactionObjectCopyWith<$Res> {
  factory $NewTransactionObjectCopyWith(NewTransactionObject value,
          $Res Function(NewTransactionObject) then) =
      _$NewTransactionObjectCopyWithImpl<$Res, NewTransactionObject>;
  @useResult
  $Res call({int amount, String note, String category, String date});
}

/// @nodoc
class _$NewTransactionObjectCopyWithImpl<$Res,
        $Val extends NewTransactionObject>
    implements $NewTransactionObjectCopyWith<$Res> {
  _$NewTransactionObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewTransactionObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? note = null,
    Object? category = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewTransactionImplCopyWith<$Res>
    implements $NewTransactionObjectCopyWith<$Res> {
  factory _$$NewTransactionImplCopyWith(_$NewTransactionImpl value,
          $Res Function(_$NewTransactionImpl) then) =
      __$$NewTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int amount, String note, String category, String date});
}

/// @nodoc
class __$$NewTransactionImplCopyWithImpl<$Res>
    extends _$NewTransactionObjectCopyWithImpl<$Res, _$NewTransactionImpl>
    implements _$$NewTransactionImplCopyWith<$Res> {
  __$$NewTransactionImplCopyWithImpl(
      _$NewTransactionImpl _value, $Res Function(_$NewTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewTransactionObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? note = null,
    Object? category = null,
    Object? date = null,
  }) {
    return _then(_$NewTransactionImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NewTransactionImpl implements _NewTransaction {
  _$NewTransactionImpl(
      {required this.amount,
      required this.note,
      required this.category,
      required this.date});

  @override
  final int amount;
  @override
  final String note;
  @override
  final String category;
  @override
  final String date;

  @override
  String toString() {
    return 'NewTransactionObject(amount: $amount, note: $note, category: $category, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewTransactionImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, note, category, date);

  /// Create a copy of NewTransactionObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewTransactionImplCopyWith<_$NewTransactionImpl> get copyWith =>
      __$$NewTransactionImplCopyWithImpl<_$NewTransactionImpl>(
          this, _$identity);
}

abstract class _NewTransaction implements NewTransactionObject {
  factory _NewTransaction(
      {required final int amount,
      required final String note,
      required final String category,
      required final String date}) = _$NewTransactionImpl;

  @override
  int get amount;
  @override
  String get note;
  @override
  String get category;
  @override
  String get date;

  /// Create a copy of NewTransactionObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewTransactionImplCopyWith<_$NewTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
