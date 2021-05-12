import 'dart:convert';
import 'package:anime_downloader/services/desc_json_to_dart.dart';
import 'package:anime_downloader/services/search_json_to_dart.dart';
import 'package:http/http.dart' as http;

class API_Service {
  Future<void> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      List<Search> result = List<Search>.from(r.map((e) => Search.fromJson(e)));
      for (int i = 0; i < result.length; i++) {
        print(result[i].name);
        print(result[i].link);
        print(result[i].image);
        print(result[i].release);
      }
    } else {
      print('Couldn\'t get data');
    }
  }

  Future<void> desc({String link}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/desc?link=$link');
    if (response.statusCode == 200) {
      var r = jsonDecode(response.body);
      var result = Desc.fromJson(r);
      print(result.id);
      print(result.name);
      print(result.type);
      print(result.summary);
      print(result.genre);
      print(result.release);
      print(result.status);
      print(result.otherNames);
      print(result.episodeStart);
      print(result.episodeEnd);
    } else {
      print("Failed");
    }
  }

  Future<void> episodes({String start, String end, String id}) async {
    http.Response response = await http.get(
        'https://anime-web-scraper.herokuapp.com/episodes?start=$start&end=$end&id=$id');
    if (response.statusCode == 200) {}
  }
}
