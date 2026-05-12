/// Application-level failures for repositories and BLoCs.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

final class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error']);
}

final class ServerException extends AppException {
  const ServerException([super.message = 'Server error']);
}

final class CacheException extends AppException {
  const CacheException([super.message = 'Local data error']);
}

final class ParseException extends AppException {
  const ParseException([super.message = 'Invalid data']);
}
