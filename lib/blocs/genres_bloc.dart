import 'dart:async';
import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class GenresBloc{
  NameLinkRepository _genresRepository;
  StreamController _genresController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get genresSink => _genresController.sink;
  Stream<ApiResponse<List<NameLinkModel>>> get genresStream => _genresController.stream;

  GenresBloc(){
    _genresController = StreamController<ApiResponse<List<NameLinkModel>>>();
    _genresRepository = NameLinkRepository();
    fetchGenres();
  }

  fetchGenres() async{
    genresSink.add(ApiResponse.loading('Fetching Genres'));
    try{
      List<NameLinkModel> links = await _genresRepository.fetchGenres();
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