import 'dart:async';
import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/repository/episode_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class EpisodeBloc {
  EpisodeRepository _episodeRepository;
  StreamController _episodeController;

  StreamSink<ApiResponse<List<EpisodeModel>>> get episodeSink =>
      _episodeController.sink;

  Stream<ApiResponse<List<EpisodeModel>>> get episodeStream =>
      _episodeController.stream;

  EpisodeBloc({String start, String end, String id, String name}) {
    _episodeController = StreamController<ApiResponse<List<EpisodeModel>>>();
    _episodeRepository = EpisodeRepository();
    fetchEpisodes(start: start, end: end, id: id, name: name);
  }

  fetchEpisodes({String start, String end, String id, String name}) async {
    episodeSink.add(ApiResponse.loading('Fetching Episodes'));
    try {
      List<EpisodeModel> episodes = await _episodeRepository.fetchEpisodes(
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
