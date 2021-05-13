import 'package:anime_downloader/model/download_links_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class DownloadLinkRepository {
  ApiService _service = ApiService();

  Future<List<DownloadLinkModel>> downloadLink({String link}) async {
    final Iterable response = await _service.get('/downloadLink?link=$link');
    return List<DownloadLinkModel>.from(
        response.map((e) => DownloadLinkModel.fromJson(e)));
  }
}
