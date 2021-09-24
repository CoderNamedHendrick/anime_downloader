import '../error/app_failures.dart';
import 'data_response.dart';

mixin ErrorCatchMixin {
  DataResponse<T> catchSyncError<T>(DataResponse<T> Function() callback) {
    try {
      return callback();
    } on Exception catch (e) {
      return DataResponse(
        error: handleException(e),
      );
    }
  }

  Future<DataResponse<T>> catchASyncError<T>(
      Future<DataResponse<T>> Function() callback) async {
    try {
      return await callback();
    } on Exception catch (e) {
      return DataResponse(
        error: handleException(e),
      );
    }
  }
}
