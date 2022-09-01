import 'dart:async';

import 'package:anime_downloader/model/name_link.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class AnimeByLetterBloc {
 late  NameLinkRepository _animeByLetterRepository;
  late StreamController<ApiResponse<List<NameLinkModel>>> _animeByLetterController;

  StreamSink<ApiResponse<List<NameLinkModel>>>? get animeByLetterSink =>
      _animeByLetterController.sink;
  Stream<ApiResponse<List<NameLinkModel>>> get animeByLetterStream =>
      _animeByLetterController.stream;

  AnimeByLetterBloc({required String name}) {
    _animeByLetterController =
        StreamController<ApiResponse<List<NameLinkModel>>>();
    _animeByLetterRepository = NameLinkRepository();
    fetchDownloadLinks(name: name);
  }

  fetchDownloadLinks({required String name}) async {
    animeByLetterSink?.add(ApiResponse.loading('Fetching download links'));
    try {
      List<NameLinkModel> links =
          await _animeByLetterRepository.fetchAnimeByLetter(name: name);
      animeByLetterSink?.add(ApiResponse.completed(links));
    } catch (e) {
      animeByLetterSink?.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _animeByLetterController.close();
  }
}
