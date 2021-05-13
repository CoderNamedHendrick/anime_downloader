import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class EpisodeRepository {
  ApiService _service = ApiService();

  Future<List<EpisodeModel>> episodes(
      {String start, String end, String id}) async {
    final Iterable response =
        await _service.get('/episodes?start=$start&end=$end&id=$id');
    return List<EpisodeModel>.from(r.map((e) => EpisodeModel.fromJson(e)));
  }
}
