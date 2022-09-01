import 'package:anime_downloader/model/description.dart';
import 'package:anime_downloader/model/popular.dart';
import 'package:anime_downloader/services/api_service.dart';

class DescriptionRepository {
  ApiService _service = ApiService();

  Future<DescriptionModel> fetchDesc({String? link}) async {
    final response = await _service.get('/desc?link=$link');
    return DescriptionModel.fromJson(response);
  }

  Future<List<PopularModel>> fetchPopular() async {
    final response = await _service.get('/popular');
    return List<PopularModel>.from(
        response.map((e) => PopularModel.fromJson(e)));
  }
}
