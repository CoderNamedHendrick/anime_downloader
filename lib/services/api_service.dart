import 'dart:convert';
import 'package:anime_downloader/model/description_model.dart';
import 'package:anime_downloader/model/download_links_model.dart';
import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/model/search_model.dart';
import 'package:http/http.dart' as http;

class ApiService{
  ApiService._();
  static final instance = ApiService._();

  Future<List<SearchModel>> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      return List<SearchModel>.from(r.map((e) => SearchModel.fromJson(e)));
    }
  }

  Future<DescriptionModel> desc({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/desc?link=$link');
    if (response.statusCode == 200) {
      var r = jsonDecode(response.body);
      return DescriptionModel.fromJson(r);
    }
  }

  Future<List<EpisodeModel>> episodes({String start, String end, String id}) async {
    http.Response response = await http.get(
        'https://anime-web-scraper.herokuapp.com/episodes?start=$start&end=$end&id=$id');
    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      return
          List<EpisodeModel>.from(r.map((e) => EpisodeModel.fromJson(e)));

    } else {
      print('failed');
    }
  }

  Future<List<DownloadLinkModel>> downloadLink({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/downloadLink?link=$link');
    if(response.statusCode == 200){
      Iterable r = jsonDecode(response.body);
      return List<DownloadLinkModel>.from(r.map((e) => DownloadLinkModel.fromJson(e)));
    }
  }
}