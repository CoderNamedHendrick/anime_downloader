class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class InputException implements Exception {
  final String message;

  InputException(this.message);
}

class NetworkException implements Exception {
  final String? message;

  NetworkException({this.message});
}
