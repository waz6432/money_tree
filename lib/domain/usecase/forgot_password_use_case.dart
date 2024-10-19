import 'package:dartz/dartz.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/domain/repository/repository.dart';
import 'package:financial_ledger/domain/usecase/base_use_case.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String email) async {
    return await _repository.forgotPassword(email);
  }
}
