
import 'dart:async';

import 'package:anime_downloader/model/search_model.dart';
import 'package:anime_downloader/repository/search_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class SearchBloc{
  SearchRepository _searchRepository;

  StreamController _searchListController;

  StreamSink<ApiResponse<List<SearchModel>>> get searchListSink => _searchListController.sink;

  Stream<ApiResponse<List<SearchModel>>> get searchListStream => _searchListController.stream;

  SearchBloc({String name}) {
    _searchListController = StreamController<ApiResponse<List<SearchModel>>>();
    _searchRepository = SearchRepository();
    fetchSearchList(name: name);
  }

  fetchSearchList({String name}) async{
    searchListSink.add(ApiResponse.loading('Fetching Anime'));
    try{
      List<SearchModel> searches = await _searchRepository.search(name: name);
      searchListSink.add(ApiResponse.completed(searches));
    } catch(e){
      searchListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _searchListController?.close();
  }
}