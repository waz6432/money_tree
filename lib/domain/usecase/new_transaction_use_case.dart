import 'package:dartz/dartz.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/repository/repository.dart';
import 'package:financial_ledger/domain/usecase/base_use_case.dart';

class NewTransactionUseCase implements BaseUseCase<NewTransactionUseCaseInput, NewTransaction> {
  final Repository _repository;
  NewTransactionUseCase(this._repository);

  @override
  Future<Either<Failure, NewTransaction>> execute(NewTransactionUseCaseInput input) async {
    return await _repository.newTransaction(NewTransactionRequest(
      amount: input.amount,
      note: input.note,
      category: input.category,
      date: input.date,
    ));
  }
}

class NewTransactionUseCaseInput {
  int amount;
  String note;
  String category;
  String date;

  NewTransactionUseCaseInput({
    required this.amount,
    required this.note,
    required this.category,
    required this.date,
  });
}
