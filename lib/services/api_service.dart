import 'dart:convert';
import 'package:anime_downloader/services/search_json_to_dart.dart';
import 'package:http/http.dart' as http;
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show Json, JsonMapper, JsonProperty, jsonSerializable;

class API_Service {

  Future<void> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    Iterable r = jsonDecode(response.body);
    List<Search> result = List<Search>.from(r.map((e) => Search.fromJson(e)));
    for(int i = 0; i < result.length; i++){
      print(result[i].name);
      print(result[i].link);
      print(result[i].image);
      print(result[i].release);
    }
  }
}
