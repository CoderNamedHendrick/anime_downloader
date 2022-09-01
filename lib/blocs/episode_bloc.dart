import 'dart:async';

import 'package:anime_downloader/model/name_link.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class EpisodeBloc {
  late NameLinkRepository _episodeRepository;
  late StreamController<ApiResponse<List<NameLinkModel>>> _episodeController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get episodeSink =>
      _episodeController.sink;

  Stream<ApiResponse<List<NameLinkModel>>> get episodeStream =>
      _episodeController.stream;

  EpisodeBloc({required String start, required String end, required String id, required String name}) {
    _episodeController = StreamController<ApiResponse<List<NameLinkModel>>>();
    _episodeRepository = NameLinkRepository();
    fetchEpisodes(start: start, end: end, id: id, name: name);
  }

  fetchEpisodes({required String start, required String end, required String id, required String name}) async {
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
