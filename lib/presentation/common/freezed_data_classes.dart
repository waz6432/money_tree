import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({required String userName, required String passowrd}) = _LoginObject;
}

@freezed
class EmailObject with _$EmailObject {
  factory EmailObject({required String email}) = _EmailObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject({
    required String countryMobileCode,
    required String userName,
    required String email,
    required String password,
    required String mobileNumber,
    required String profilePicture,
  }) = _RegisterObject;
}
