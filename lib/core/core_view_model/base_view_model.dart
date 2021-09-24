import 'package:flutter/cupertino.dart';

import '../error/app_failures.dart';

enum ViewState { busy, idle, error, noInternet, done }

class BaseViewModel extends ChangeNotifier {
  BaseViewModel() {
    initialize();
  }
  ViewState appState = ViewState.idle;
  bool _disposed = false;
  void initialize() {
    //Can be overridden to run on initiailize
  }
  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  setState({ViewState state = ViewState.idle}) {
    this.appState = state;
    if (!_disposed) notifyListeners();
  }

  handleFailure(Failure failure) {
    // switch (failure.runtimeType) {
    //   case ServerFailure:
    //     AppToast.instance.error(
    //       (failure as ServerFailure).message,
    //     );
    //     break;
    //   case AuthFailure:
    //     AppToast.instance.error(
    //       handleAuthFailureMessage(failure as AuthFailure),
    //     );
    //     break;
    //   case NetworkFailure:
    //     AppToast.instance.error(
    //       (failure as NetworkFailure).message ?? '',
    //     );
    //     break;
    //   case InputFailure:
    //     AppToast.instance.error(
    //       (failure as InputFailure).message,
    //     );
    //     break;
    //   default:
    // }
  }

  String handleAuthFailureMessage(AuthFailure? failure) {
    switch (failure?.failureCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already in use";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "This user has been disabled";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests have been logged, please try again later.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Action failed. Please try again.";
    }
  }
}
