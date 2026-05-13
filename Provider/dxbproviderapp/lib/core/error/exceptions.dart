import 'package:dio/dio.dart';

import 'failures.dart';

class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

Failure mapExceptionToFailure(Object e) {
  if (e is Failure) return e;
  if (e is AppException) return UnknownFailure(e.message);
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkFailure(e.message ?? 'Connection failed');
      case DioExceptionType.badResponse:
        return ServerFailure(e.message ?? 'Bad response');
      default:
        return UnknownFailure(e.message ?? 'Request failed');
    }
  }
  return UnknownFailure(e.toString());
}
