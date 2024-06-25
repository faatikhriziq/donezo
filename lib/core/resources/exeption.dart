class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class AuthException implements Exception {
  final String code;
  final String message;

  AuthException({required this.code, required this.message});

  @override
  String toString() {
    return 'AuthException: $code - $message';
  }
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class InvalidInputException implements Exception {
  final String message;

  InvalidInputException(this.message);
}
