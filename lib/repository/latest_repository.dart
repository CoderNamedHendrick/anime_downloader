import 'package:anime_downloader/model/latest.dart';
import 'package:anime_downloader/services/api_service.dart';

class LatestAnimeRepository {
  ApiService _service = ApiService();

  Future<List<LatestAnimeModel>> fetchLatest({String? page}) async {
    final response = await _service.get('/recent?page=$page');
    return List<LatestAnimeModel>.from(
        response.map((e) => LatestAnimeModel.fromJson(e)));
  }
}
