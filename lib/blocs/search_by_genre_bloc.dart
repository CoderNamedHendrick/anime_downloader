import 'dart:async';

import 'package:anime_downloader/model/search.dart';
import 'package:anime_downloader/repository/search_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class SearchByGenreBloc {
  SearchRepository _searchByGenreRepository;

  StreamController _searchByGenreListController;

  StreamSink<ApiResponse<List<SearchModel>>> get searchListSink =>
      _searchByGenreListController.sink;

  Stream<ApiResponse<List<SearchModel>>> get searchListStream =>
      _searchByGenreListController.stream;

  SearchByGenreBloc({String name}) {
    _searchByGenreListController =
        StreamController<ApiResponse<List<SearchModel>>>();
    _searchByGenreRepository = SearchRepository();
    fetchSearchList(name: name);
  }

  fetchSearchList({String name}) async {
    searchListSink.add(ApiResponse.loading('Fetching Anime'));
    try {
      List<SearchModel> searches =
          await _searchByGenreRepository.searchByGenre(link: name);
      searchListSink.add(ApiResponse.completed(searches));
    } catch (e) {
      searchListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _searchByGenreListController?.close();
  }
}
