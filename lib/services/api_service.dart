import 'dart:convert';
import 'package:anime_downloader/services/desc_json_to_dart.dart';
import 'package:anime_downloader/services/search_json_to_dart.dart';
import 'package:http/http.dart' as http;
import 'package:dart_json_mapper/dart_json_mapper.dart'
    show Json, JsonMapper, JsonProperty, jsonSerializable;

class API_Service {

  Future<void> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    if(response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);
      List<Search> result = List<Search>.from(r.map((e) => Search.fromJson(e)));
      for (int i = 0; i < result.length; i++) {
        print(result[i].name);
        print(result[i].link);
        print(result[i].image);
        print(result[i].release);
      }
    } else {print('Couldn\'t get data');}
  }

  Future<void> desc({String link}) async{
    http.Response response = await http.get('https://anime-web-scraper.herokuapp.com/desc?link=$link');
    if(response.statusCode == 200){
      Iterable r = jsonDecode(response.body);
      List<Desc> result = List<Desc>.from(r.map((e) => Desc.fromJson(e)));
      for(int i = 0; i < result.length; i++){
        print(result[i].id);
        print(result[i].name);
        print(result[i].type);
        print(result[i].summary);
        print(result[i].genre);
        print(result[i].release);
        print(result[i].status);
        print(result[i].otherNames);
        print(result[i].episodeStart);
        print(result[i].episodeEnd);
      }
    }
  }
}
