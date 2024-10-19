import 'package:dartz/dartz.dart';
import 'package:financial_ledger/app/functions.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/repository/repository.dart';
import 'package:financial_ledger/domain/usecase/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authetication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authetication>> execute(LoginUseCaseInput input) async {
    final DeviceInfo deviceInfo = await getDeviceDetails();

    return await _repository.login(LoginRequest(
      email: input.email,
      password: input.password,
      imei: deviceInfo.identifier,
      deviceType: deviceInfo.name,
    ));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput({required this.email, required this.password});
}
