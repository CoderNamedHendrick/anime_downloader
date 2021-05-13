import 'dart:async';
import 'package:anime_downloader/model/download_links_model.dart';
import 'package:anime_downloader/repository/downloads_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class DownloadLinkBloc{
  DownloadLinkRepository _downloadLinkRepository;
  StreamController _downloadLinkController;

  StreamSink<ApiResponse<List<DownloadLinkModel>>> get downloadLinkSink => _downloadLinkController.sink;
  Stream<ApiResponse<List<DownloadLinkModel>>> get downloadLinkStream => _downloadLinkController.stream;

  DownloadLinkBloc({String link}){
    _downloadLinkController = StreamController<ApiResponse<List<DownloadLinkModel>>>();
    _downloadLinkRepository = DownloadLinkRepository();
    fetchDownloadLinks(link);
  }

  fetchDownloadLinks(String link) async{
    downloadLinkSink.add(ApiResponse.loading('Fetchink download links'));
    try{
      List<DownloadLinkModel> links = await _downloadLinkRepository.fetchDownloadLink(link: link);
      downloadLinkSink.add(ApiResponse.completed(links));
    } catch (e){
      downloadLinkSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _downloadLinkController?.close();
  }
}