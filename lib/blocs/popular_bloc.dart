import 'dart:async';

import 'package:anime_downloader/model/popular.dart';
import 'package:anime_downloader/repository/description_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class PopularBloc {
  late DescriptionRepository _popularRepository;
  late StreamController<ApiResponse<List<PopularModel>>> _popularController;

  StreamSink<ApiResponse<List<PopularModel>>> get popularSink =>
      _popularController.sink;
  Stream<ApiResponse<List<PopularModel>>> get popularStream =>
      _popularController.stream;

  PopularBloc() {
    _popularController = StreamController<ApiResponse<List<PopularModel>>>();
    _popularRepository = DescriptionRepository();
    fetchPopular();
  }

  fetchPopular() async {
    popularSink.add(ApiResponse.loading('Fetching popular'));
    try {
      List<PopularModel> popular = await _popularRepository.fetchPopular();
      popularSink.add(ApiResponse.completed(popular));
    } catch (e) {
      popularSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _popularController.close();
  }
}
