import 'dart:convert';
import 'dart:io';
import 'package:anime_downloader/services/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://anime-web-scraper.herokuapp.com';

  Future<dynamic> get (String url) async{
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException{
      print('No net');
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body);
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
