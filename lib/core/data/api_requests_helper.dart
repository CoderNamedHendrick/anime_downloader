import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:wole_app/core/dependency_injection/locator.dart';
import 'package:wole_app/services/local_storage_service.dart';

import '../error/app_failures.dart';
import 'data_response.dart';
import 'error_catch_mixin.dart';

class ApiRequestsHelper with ErrorCatchMixin {
  var tokenData = locator<LocalStorageService>();
  final String baseUrl = 'https://wole-api.herokuapp.com/api';
  static String? _token;

  static set token(String token) {
    _token = token;
  }

  String? get userToken => _token;
  Map<String, String> get jsonHeadersWithoutToken => {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

  Map<String, String> get jsonHeaders => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };

  Map<String, String> get jsonHeadersFormData => {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $_token',
      };

  Future<DataResponse<Map<String, dynamic>>> sendGet(String endpoint,
      {bool isNotMapResponse = false,
      Map<String, dynamic> Function(dynamic responseData)? mapConversion,
      bool withToken = false}) async {
    return catchASyncError<Map<String, dynamic>>(() async {
      if (withToken) {
        String? userToken = await tokenData.getTokenData();
        token = userToken.toString();
      }
      final http.Response response = await http.get(
        Uri.parse('$baseUrl${endpoint.trim()}'),
        headers: withToken ? jsonHeaders : jsonHeadersWithoutToken,
      );
      print('Response status: ${response.statusCode}');
      final error = _checkForError(response.statusCode);
      var data = jsonDecode(response.body);
      if (isNotMapResponse) {
        if (mapConversion != null) {
          data = mapConversion(data);
        } else {
          data = {'data': data};
        }
      }
      return DataResponse<Map<String, dynamic>>(
        data: data,
        error: error,
      );
    });
  }

  Future<DataResponse<Map<String, dynamic>>> sendPost(String endpoint,
      {required Map<String, dynamic> body,
      bool isNotMapResponse = false,
      Map<String, dynamic> Function(dynamic responseData)? mapConversion,
      bool withToken = false}) async {
    return catchASyncError<Map<String, dynamic>>(() async {
      if (withToken) {
        String? userToken = await tokenData.getTokenData();
        token = userToken.toString();
      }
      final http.Response response = await http.post(
        Uri.parse('$baseUrl${endpoint.trim()}'),
        headers: withToken ? jsonHeaders : jsonHeadersWithoutToken,
        body: json.encode(body),
      );
      final error = _checkForError(response.statusCode);
      var data = jsonDecode(response.body);

      if (isNotMapResponse) {
        if (mapConversion != null) {
          data = mapConversion(data);
        } else {
          data = {'data': data};
        }
      }
      return DataResponse<Map<String, dynamic>>(
        data: data,
        error: error,
      );
    });
  }

  Future<DataResponse<Map<String, dynamic>>> sendImageFile({
    required File image,
    required String imageKey,
    required String endpoint,
    Map<String, dynamic>? fields,
    String requestType = 'POST',
    bool isNotMapResponse = false,
    Map<String, dynamic> Function(dynamic responseData)? mapConversion,
  }) async {
    String? userToken = await tokenData.getTokenData();
    token = userToken.toString();

    // Make request variable with url
    final request = http.MultipartRequest(
      requestType,
      Uri.parse('$baseUrl$endpoint'),
    );
// Add authorisation header to request variable
    request.headers.putIfAbsent(
      'Authorization',
      () => jsonHeaders['Authorization']!,
    );
// Add the image file to request variable as imageKey

    request.files.add(await http.MultipartFile.fromPath(
      imageKey,
      image.path,
      filename: basename(image.path),
      contentType: MediaType('image', 'jpeg'),
    ));

// If other fields exist, add them to the request
    if (fields != null && fields.isNotEmpty) {
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    final multipartRequest =
        await http.Response.fromStream(await request.send());
    final error = _checkForError(multipartRequest.statusCode);
    print(error);
    print(multipartRequest.body);
    print("response: ${multipartRequest.statusCode}");
    var data = jsonDecode(multipartRequest.body);

    if (isNotMapResponse) {
      if (mapConversion != null) {
        data = mapConversion(data);
      } else {
        data = {'data': data};
      }
    }
    return DataResponse<Map<String, dynamic>>(
      data: data,
      error: error,
    );
  }

  Future<DataResponse<Map<String, dynamic>>> sendPut(
    String endpoint, {
    required Map<String, dynamic> body,
    bool isNotMapResponse = false,
    bool withToken = true,
    Map<String, dynamic> Function(dynamic responseData)? mapConversion,
  }) {
    return catchASyncError<Map<String, dynamic>>(() async {
      if (withToken) {
        String? userToken = await tokenData.getTokenData();
        token = userToken.toString();
      }
      final http.Response response = await http.put(
        Uri.parse('$baseUrl${endpoint.trim()}'),
        headers: jsonHeaders,
        body: json.encode(body),
      );

      final error = _checkForError(response.statusCode);
      var data = jsonDecode(response.body);

      if (isNotMapResponse) {
        if (mapConversion != null) {
          data = mapConversion(data);
        } else {
          data = {'data': data};
        }
      }
      return DataResponse<Map<String, dynamic>>(
        data: data,
        error: error,
      );
    });
  }

  Future<DataResponse<Map<String, dynamic>>> sendDelete(
    String endpoint, {
    bool isNotMapResponse = false,
    bool withToken = true,
    Map<String, dynamic> Function(dynamic responseData)? mapConversion,
  }) {
    return catchASyncError<Map<String, dynamic>>(() async {
      if (withToken) {
        String? userToken = await tokenData.getTokenData();
        token = userToken.toString();
      }
      final http.Response response = await http.delete(
        Uri.parse('$baseUrl${endpoint.trim()}'),
        headers: jsonHeaders,
      );

      final error = _checkForError(response.statusCode);
      var data = jsonDecode(response.body);

      if (isNotMapResponse) {
        if (mapConversion != null) {
          data = mapConversion(data);
        } else {
          data = {'data': data};
        }
      }
      return DataResponse<Map<String, dynamic>>(
        data: data,
        error: error,
      );
    });
  }
}

Failure? _checkForError(int statusCode) {
  if (statusCode >= 200) {
    return null;
  } else if (statusCode >= 400) {
    return AuthFailure(message: '');
  } else if (statusCode >= 500) {
    return ServerFailure(
        'We couldn\'t process your request at this time, please try again later.'
        '');
  } else {
    return NetworkFailure(
        message:
            'Couldn\'t reach the servers at the moment, please try again.');
  }
}
