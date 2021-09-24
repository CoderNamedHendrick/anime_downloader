import 'app_exceptions.dart';

abstract class Failure {
  String? message;
}

class AuthFailure extends Failure {
  final String message;
  final String? failureCode;

  AuthFailure(
      {this.message = 'An error occurred, please try again.',
      this.failureCode});
}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure(this.message);
}

class InputFailure extends Failure {
  final String message;

  InputFailure(this.message);
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);
}

class NetworkFailure extends Failure {
  final String? message;

  NetworkFailure({this.message});
}

class UnknownFirebaseFailure extends Failure {
  final String message;
  final String? code;

  UnknownFirebaseFailure(
      {this.message = 'An error occurred, please try again.', this.code});
}

Failure handleException(Exception e) {
  if (e is ServerException) {
    return ServerFailure(e.message);
  } else if (e is NetworkException) {
    return NetworkFailure(message: e.message);
  } else if (e is InputException) {
    return InputFailure(e.message);
  }
  return UnknownFailure("An Unknown Error occurred");
}
