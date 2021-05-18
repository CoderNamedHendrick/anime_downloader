import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class DownloadLinkRepository {
  ApiService _service = ApiService();

  Future<List<NameLinkModel>> fetchDownloadLink({String link}) async {
    final Iterable response = await _service.get('/downloadLink?link=$link');
    return List<NameLinkModel>.from(
        response.map((e) => NameLinkModel.fromJson(e)));
  }
}
