import 'dart:async';

import 'package:anime_downloader/model/latest_model.dart';
import 'package:anime_downloader/repository/latest_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class LatestAnimeBloc{
  LatestAnimeRepository _latestRepository;
  StreamController _latestController;

  StreamSink<ApiResponse<List<LatestAnimeModel>>> get latestSink =>
      _latestController.sink;
  Stream<ApiResponse<List<LatestAnimeModel>>> get latestStream =>
      _latestController.stream;

  LatestAnimeBloc(){
    _latestController = StreamController<ApiResponse<List<LatestAnimeModel>>>();
    _latestRepository = LatestAnimeRepository();
    fetchLatest();
  }

  fetchLatest({String page:"1"}) async{
    latestSink.add(ApiResponse.loading('Fetching Latest Anime'));
    try{
      List<LatestAnimeModel> latest = await _latestRepository.fetchLatest(page: page);
      latestSink.add(ApiResponse.completed(latest));
    } catch(e){
      latestSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
}