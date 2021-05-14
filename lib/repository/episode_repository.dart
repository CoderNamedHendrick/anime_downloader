import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class EpisodeRepository {
  ApiService _service = ApiService();

  Future<List<EpisodeModel>> fetchEpisodes(
      {String start, String end, String id, String name}) async {
    final Iterable response =
        await _service.get('/episodes?start=$start&end=$end&id=$id&name=$name');
    return List<EpisodeModel>.from(response.map((e) => EpisodeModel.fromJson(e)));
  }
}
