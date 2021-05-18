import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/services/api_service.dart';

class NameLinkRepository {
  ApiService _service = ApiService();

  Future<List<NameLinkModel>> fetchEpisodes(
      {String start, String end, String id, String name}) async {
    final Iterable response =
        await _service.get('/episodes?start=$start&end=$end&id=$id&name=$name');
    return List<NameLinkModel>.from(response.map((e) => NameLinkModel.fromJson(e)));
  }

  Future<List<NameLinkModel>> fetchDownloadLink({String link}) async {
    final Iterable response = await _service.get('/downloadLink?link=$link');
    return List<NameLinkModel>.from(
        response.map((e) => NameLinkModel.fromJson(e)));
  }

  Future<List<NameLinkModel>> fetchAnimeByLetter({String name}) async{
    final Iterable response = await _service.get('/letters?name=$name');
    return List<NameLinkModel>.from(response.map((e) => NameLinkModel.fromJson(e)));
  }

  Future<List<NameLinkModel>> fetchGenres() async{
    final Iterable response = await _service.get('/genres');
    return List<NameLinkModel>.from(response.map((e) => NameLinkModel.fromJson(e)));
  }
}
