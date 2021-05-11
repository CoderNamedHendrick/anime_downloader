import 'dart:convert';
import 'package:http/http.dart' as http;

class API_Service {
  String _name;
  String _link;
  String _image;
  String _release;

  Future<void> search({String name}) async {
    http.Response response = await http
        .get('https://anime-web-scraper.herokuapp.com/search?name=$name');
    var result = jsonDecode(response.body);
    this._name = result[0]['name'];
    this._link = result[0]['link'];
    this._image = result[0]['image'];
    this._release = result[0]['release'];
    this._release = this._release.replaceAll("\n", "").replaceAll(" ", "");
    print(this._name);
    print(this._link);
    print(this._image);
    print(this._release);
  }

  Future<String> results() async {
    return await ("name: " +
        this._name +
        "\nlink: " +
        this._link +
        "\nimage: " +
        this._image +
        "\nrelease: " +
        this._release);
  }
}
