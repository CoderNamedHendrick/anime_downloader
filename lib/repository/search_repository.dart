import 'package:anime_downloader/model/search_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class SearchRepository {
  ApiService _service = ApiService();

  Future<List<SearchModel>> search({String name}) async {
    final Iterable response = await _service.get('/search?name=$name');
    return List<SearchModel>.from(response.map((e) => SearchModel.fromJson(e)));
  }
}
