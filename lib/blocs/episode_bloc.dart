import 'dart:async';

import 'package:anime_downloader/model/name_link.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class EpisodeBloc {
  NameLinkRepository _episodeRepository;
  StreamController _episodeController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get episodeSink =>
      _episodeController.sink;

  Stream<ApiResponse<List<NameLinkModel>>> get episodeStream =>
      _episodeController.stream;

  EpisodeBloc({String start, String end, String id, String name}) {
    _episodeController = StreamController<ApiResponse<List<NameLinkModel>>>();
    _episodeRepository = NameLinkRepository();
    fetchEpisodes(start: start, end: end, id: id, name: name);
  }

  fetchEpisodes({String start, String end, String id, String name}) async {
    episodeSink.add(ApiResponse.loading('Fetching Episodes'));
    try {
      List<NameLinkModel> episodes = await _episodeRepository.fetchEpisodes(
        start: start,
        end: end,
        id: id,
        name: name,
      );
      episodeSink.add(ApiResponse.completed(episodes));
    } catch (e) {
      episodeSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _episodeController.close();
  }
}
