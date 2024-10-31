import 'package:dartz/dartz.dart';
import 'package:financial_ledger/data/data_source/local_data_source.dart';
import 'package:financial_ledger/data/data_source/remote_data_source.dart';
import 'package:financial_ledger/data/mapper/mapper.dart';
import 'package:financial_ledger/data/network/error_handler.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/data/network/network_info.dart';
import 'package:financial_ledger/data/request/request.dart';
import 'package:financial_ledger/domain/model/model.dart';
import 'package:financial_ledger/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authetication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data (success)
          return Right(response.toDomain());
        } else {
          // return biz logic error (failure)
          return Left(Failure(
            code: response.status ?? ApiInternalStatus.FAILURE,
            message: response.message ?? ResponseMessage.DEFAULT_ERROR,
          ));
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data (success)
          return Right(response.toDomain());
        } else {
          return Left(Failure(
            code: response.status ?? ApiInternalStatus.FAILURE,
            message: response.message ?? ResponseMessage.DEFAULT_ERROR,
          ));
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authetication>> register(RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data (success)
          return Right(response.toDomain());
        } else {
          return Left(Failure(
            code: response.status ?? ApiInternalStatus.FAILURE,
            message: response.message ?? ResponseMessage.DEFAULT_ERROR,
          ));
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // 캐시 데이터
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // 캐시 에러 (get API 데이터)
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // return data (success)
            // save reponse local data
            _localDataSource.saveHomeToCache(homeResponse: response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(
              code: response.status ?? ApiInternalStatus.FAILURE,
              message: response.message ?? ResponseMessage.DEFAULT_ERROR,
            ));
          }
        } catch (exception) {
          return Left(ErrorHandler.handle(exception).failure);
        }
      } else {
        // connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NewTransaction>> newTransaction(NewTransactionRequest newTransactionRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.newTransaction(newTransactionRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // return data (success)
          return Right(response.toDomain());
        } else {
          return Left(Failure(
            code: response.status ?? ApiInternalStatus.FAILURE,
            message: response.message ?? ResponseMessage.DEFAULT_ERROR,
          ));
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ReportObject>> getReport() async {
    try {
      // 캐시 데이터
      final response = await _localDataSource.getReport();
      return Right(response.toDomain());
    } catch (cacheError) {
      // 캐시 에러 (get API 데이터)
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getReport();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // return data (success)
            // save reponse local data
            _localDataSource.saveReportToCache(reportResponse: response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(
              code: response.status ?? ApiInternalStatus.FAILURE,
              message: response.message ?? ResponseMessage.DEFAULT_ERROR,
            ));
          }
        } catch (exception) {
          return Left(ErrorHandler.handle(exception).failure);
        }
      } else {
        // connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
