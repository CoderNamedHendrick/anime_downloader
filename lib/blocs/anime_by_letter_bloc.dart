
import 'dart:async';

import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class AnimeByLetterBloc{
  NameLinkRepository _animeByLetterRepository;
  StreamController _animeByLetterController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get animeByLetterSink => _animeByLetterController.sink;
  Stream<ApiResponse<List<NameLinkModel>>> get animeByLetterStream => _animeByLetterController.stream;

  AnimeByLetterBloc({String name}){
    _animeByLetterController = StreamController<ApiResponse<List<NameLinkModel>>>();
    _animeByLetterRepository = NameLinkRepository();
    fetchDownloadLinks(name: name);
  }

  fetchDownloadLinks({String name}) async{
    animeByLetterSink.add(ApiResponse.loading('Fetching download links'));
    try{
      List<NameLinkModel> links = await _animeByLetterRepository.fetchAnimeByLetter(name: name);
      animeByLetterSink.add(ApiResponse.completed(links));
    } catch (e){
      animeByLetterSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _animeByLetterController?.close();
  }
}