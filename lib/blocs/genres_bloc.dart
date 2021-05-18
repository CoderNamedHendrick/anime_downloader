import 'dart:async';
import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class GenresBloc{
  NameLinkRepository _genresRepository;
  StreamController _genresController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get genresSink => _genresController.sink;
  Stream<ApiResponse<List<NameLinkModel>>> get genresStream => _genresController.stream;

  GenresBloc({String link}){
    _genresController = StreamController<ApiResponse<List<NameLinkModel>>>();
    _genresRepository = NameLinkRepository();
    fetchDownloadLinks(link: link);
  }

  fetchDownloadLinks({String link}) async{
    genresSink.add(ApiResponse.loading('Fetching download links'));
    try{
      List<NameLinkModel> links = await _genresRepository.fetchDownloadLink(link: link);
      genresSink.add(ApiResponse.completed(links));
    } catch (e){
      genresSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _genresController?.close();
  }
}