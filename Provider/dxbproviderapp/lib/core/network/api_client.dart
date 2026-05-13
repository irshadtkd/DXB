import 'package:dio/dio.dart';

/// HTTP client for future API; baseUrl optional until backend exists.
class ApiClient {
  ApiClient({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? '',
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
          ),
        );

  final Dio _dio;
  Dio get dio => _dio;
}
