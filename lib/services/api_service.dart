import 'dart:convert';
import 'package:anime_downloader/model/description_model.dart';
import 'package:anime_downloader/model/download_links_model.dart';
import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/model/search_model.dart';
import 'package:anime_downloader/services/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();
  static final instance = ApiService._();

  Future<List<SearchModel>> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    Iterable r = _returnResponse(response);
    return List<SearchModel>.from(r.map((e) => SearchModel.fromJson(e)));
  }

  Future<DescriptionModel> desc({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/desc?link=$link');
    var r = _returnResponse(response);
    return DescriptionModel.fromJson(r);
  }

  Future<List<EpisodeModel>> episodes(
      {String start, String end, String id}) async {
    http.Response response = await http.get(
        'https://anime-web-scraper.herokuapp.com/episodes?start=$start&end=$end&id=$id');
    Iterable r = _returnResponse(response);
    return List<EpisodeModel>.from(r.map((e) => EpisodeModel.fromJson(e)));
  }

  Future<List<DownloadLinkModel>> downloadLink({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/downloadLink?link=$link');
    Iterable r = _returnResponse(response);
    return List<DownloadLinkModel>.from(
        r.map((e) => DownloadLinkModel.fromJson(e)));
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
