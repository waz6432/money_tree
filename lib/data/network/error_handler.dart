// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:financial_ledger/data/network/failure.dart';
import 'package:financial_ledger/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  BAD_CERTIFICATE,
  DEFAULT_ERROR,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic exception) {
    if (exception is DioException) {
      // dio error
      failure = _handleError(exception);
    } else {
      // default error
      failure = DataSource.DEFAULT_ERROR.getFailure();
    }
  }

  Failure _handleError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.BAD_CERTIFICATE.getFailure();
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT_ERROR.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.NO_INTERNET_CONNECTION.getFailure();
      case DioExceptionType.unknown:
        return DataSource.DEFAULT_ERROR.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS.tr());
      case DataSource.NO_CONTENT:
        return Failure(code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT.tr());
      case DataSource.BAD_REQUEST:
        return Failure(code: ResponseCode.BAD_REQUEST, message: ResponseMessage.BAD_REQUEST.tr());
      case DataSource.FORBIDDEN:
        return Failure(code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN.tr());
      case DataSource.UNAUTHORIZED:
        return Failure(code: ResponseCode.UNAUTHORIZED, message: ResponseMessage.UNAUTHORIZED.tr());
      case DataSource.NOT_FOUND:
        return Failure(code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(code: ResponseCode.INTERNAL_SERVER_ERROR, message: ResponseMessage.INTERNAL_SERVER_ERROR.tr());
      case DataSource.CONNECT_TIMEOUT:
        return Failure(code: ResponseCode.CONNECT_TIMEOUT, message: ResponseMessage.CONNECT_TIMEOUT.tr());
      case DataSource.CANCEL:
        return Failure(code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL.tr());
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(code: ResponseCode.RECEIVE_TIMEOUT, message: ResponseMessage.RECEIVE_TIMEOUT.tr());
      case DataSource.SEND_TIMEOUT:
        return Failure(code: ResponseCode.SEND_TIMEOUT, message: ResponseMessage.SEND_TIMEOUT.tr());
      case DataSource.CACHE_ERROR:
        return Failure(code: ResponseCode.CACHE_ERROR, message: ResponseMessage.CACHE_ERROR.tr());
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(code: ResponseCode.NO_INTERNET_CONNECTION, message: ResponseMessage.NO_INTERNET_CONNECTION.tr());
      case DataSource.BAD_CERTIFICATE:
        return Failure(code: ResponseCode.BAD_CERTIFICATE, message: ResponseMessage.BAD_CERTIFICATE.tr());
      case DataSource.DEFAULT_ERROR:
        return Failure(code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT_ERROR.tr());
      default:
        return Failure(code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT_ERROR.tr());
    }
  }
}

class ResponseCode {
  // api status codes
  static const int SUCCESS = 200; // 요청이 성공적으로 처리됨
  static const int NO_CONTENT = 201; // 요청이 성공적으로 처리되었으나, 반환할 콘텐츠가 없음
  static const int BAD_REQUEST = 400; // 잘못된 요청으로, 서버가 이해하지 못하거나 처리할 수 없음
  static const int FORBIDDEN = 403; // 요청이 허가되지 않음 (권한 부족)
  static const int UNAUTHORIZED = 401; // 인증 실패 또는 인증 정보가 제공되지 않음
  static const int NOT_FOUND = 404; // 요청한 리소스를 찾을 수 없음
  static const int INTERNAL_SERVER_ERROR = 500; // 서버에서 예기치 못한 에러 발생

  // local status codes
  static const int DEFAULT = -1; // 알 수 없는 에러 발생
  static const int CONNECT_TIMEOUT = -2; // 서버와 연결하는 데 시간이 초과됨
  static const int CANCEL = -3; // 요청이 취소됨
  static const int RECEIVE_TIMEOUT = -4; // 서버로부터 응답을 받는 데 시간이 초과됨
  static const int SEND_TIMEOUT = -5; // 서버로 요청을 보내는 데 시간이 초과됨
  static const int CACHE_ERROR = -6; // 캐시와 관련된 에러 발생
  static const int NO_INTERNET_CONNECTION = -7; // 인터넷 연결이 없는 경우 발생하는 에러
  static const int BAD_CERTIFICATE = -8; // TLS/SSL 인증서 오류
}

class ResponseMessage {
  // API status code
  static const String SUCCESS = AppStrings.success; // 요청이 성공적으로 처리됨
  static const String NO_CONTENT = AppStrings.noContent; // 요청이 성공적으로 처리되었으나, 반환할 콘텐츠가 없음
  static const String BAD_REQUEST = AppStrings.badRequest; // 잘못된 요청으로, 서버가 이해하지 못하거나 처리할 수 없음
  static const String FORBIDDEN = AppStrings.forbidden; // 요청이 허가되지 않음 (권한 부족)
  static const String UNAUTHORIZED = AppStrings.unauthorized; // 인증 실패 또는 인증 정보가 제공되지 않음
  static const String NOT_FOUND = AppStrings.notFound; // 요청한 리소스를 찾을 수 없음
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError; // 서버에서 예기치 못한 에러 발생

  // local status code
  static const String DEFAULT_ERROR = AppStrings.defaultError; // 알 수 없는 에러 발생
  static const String CONNECT_TIMEOUT = AppStrings.connectTimeout; // 서버와 연결하는 데 시간이 초과됨
  static const String CANCEL = AppStrings.cancel; // 요청이 취소됨
  static const String RECEIVE_TIMEOUT = AppStrings.receiveTimeout; // 서버로부터 응답을 받는 데 시간이 초과됨
  static const String SEND_TIMEOUT = AppStrings.sendTimeout; // 서버로 요청을 보내는 데 시간이 초과됨
  static const String CACHE_ERROR = AppStrings.cacheError; // 캐시와 관련된 에러 발생
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetConnection; // 인터넷 연결이 없는 경우 발생하는 에러
  static const String BAD_CERTIFICATE = AppStrings.badCertificate; // TLS/SSL 인증서 오류
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
