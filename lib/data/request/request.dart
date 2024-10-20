// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest({required this.email, required this.password, required this.imei, required this.deviceType});
}

class RegisterRequest {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterRequest({
    required this.countryMobileCode,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.profilePicture,
  });
}

class NewTransactionRequest {
  int amount;
  String note;
  String category;
  String date;

  NewTransactionRequest({
    required this.amount,
    required this.note,
    required this.category,
    required this.date,
  });
}
