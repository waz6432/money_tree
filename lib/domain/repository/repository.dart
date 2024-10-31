import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:dartz/dartz.dart';
import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authetication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authetication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, NewTransaction>> newTransaction(NewTransactionRequest newTransactionRequest);
  Future<Either<Failure, ReportObject>> getReport();
}
