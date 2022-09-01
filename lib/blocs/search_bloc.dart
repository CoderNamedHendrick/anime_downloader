import 'dart:async';

import 'package:anime_downloader/model/search.dart';
import 'package:anime_downloader/repository/search_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class SearchBloc {
  late SearchRepository _searchRepository;

  late StreamController<ApiResponse<List<SearchModel>>> _searchListController;

  StreamSink<ApiResponse<List<SearchModel>>> get searchListSink =>
      _searchListController.sink;

  Stream<ApiResponse<List<SearchModel>>> get searchListStream =>
      _searchListController.stream;

  SearchBloc({required String name}) {
    _searchListController = StreamController<ApiResponse<List<SearchModel>>>();
    _searchRepository = SearchRepository();
    fetchSearchList(name: name);
  }

  fetchSearchList({required String name}) async {
    searchListSink.add(ApiResponse.loading('Fetching Anime'));
    try {
      List<SearchModel> searches = await _searchRepository.search(name: name);
      searchListSink.add(ApiResponse.completed(searches));
    } catch (e) {
      searchListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _searchListController.close();
  }
}
