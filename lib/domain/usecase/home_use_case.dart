import 'package:dartz/dartz.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/repository/repository.dart';
import 'package:financial_ledger/domain/usecase/base_use_case.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
