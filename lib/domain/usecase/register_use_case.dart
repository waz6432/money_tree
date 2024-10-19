import 'package:dartz/dartz.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/repository/repository.dart';
import 'package:financial_ledger/domain/usecase/base_use_case.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Authetication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authetication>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      countryMobileCode: input.countryMobileCode,
      userName: input.userName,
      email: input.email,
      password: input.password,
      mobileNumber: input.mobileNumber,
      profilePicture: input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput({
    required this.countryMobileCode,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.profilePicture,
  });
}
