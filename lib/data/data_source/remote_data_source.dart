import 'package:financial_ledger/data/network/app_api.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:financial_ledger/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      email: loginRequest.email,
      password: loginRequest.password,
      imei: "",
      deviceType: "",
      // imei: loginRequest.imei,
      // deviceType: loginRequest.deviceType,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email: email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      countryMobileCode: registerRequest.countryMobileCode,
      userName: registerRequest.userName,
      email: registerRequest.email,
      password: registerRequest.password,
      mobileNumber: registerRequest.mobileNumber,
      profilePicture: registerRequest.profilePicture,
    );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }
}
