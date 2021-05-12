import 'dart:convert';
import 'package:anime_downloader/services/desc_json_to_dart.dart';
import 'package:anime_downloader/services/download_links_json_to_dart.dart';
import 'package:anime_downloader/services/episodes_json_to_dart.dart';
import 'package:anime_downloader/services/search_json_to_dart.dart';
import 'package:http/http.dart' as http;

class ApiService{
  ApiService._();
  static final instance = ApiService._();

  Future<List<Search>> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      return List<Search>.from(r.map((e) => Search.fromJson(e)));
    }
  }

  Future<Desc> desc({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/desc?link=$link');
    if (response.statusCode == 200) {
      var r = jsonDecode(response.body);
      return Desc.fromJson(r);
    }
  }

  Future<List<Episodes>> episodes({String start, String end, String id}) async {
    http.Response response = await http.get(
        'https://anime-web-scraper.herokuapp.com/episodes?start=$start&end=$end&id=$id');
    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      return
          List<Episodes>.from(r.map((e) => Episodes.fromJson(e)));

    } else {
      print('failed');
    }
  }

  Future<List<DownloadLink>> downloadLink({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/downloadLink?link=$link');
    if(response.statusCode == 200){
      Iterable r = jsonDecode(response.body);
      return List<DownloadLink>.from(r.map((e) => DownloadLink.fromJson(e)));
    }
  }
}