import 'dart:async';

import 'package:anime_downloader/model/name_link.dart';
import 'package:anime_downloader/repository/name_link_repository.dart';
import 'package:anime_downloader/services/api_response.dart';

class DownloadLinkBloc {
  late NameLinkRepository _downloadLinkRepository;
  late StreamController<ApiResponse<List<NameLinkModel>>> _downloadLinkController;

  StreamSink<ApiResponse<List<NameLinkModel>>> get downloadLinkSink =>
      _downloadLinkController.sink;
  Stream<ApiResponse<List<NameLinkModel>>> get downloadLinkStream =>
      _downloadLinkController.stream;

  DownloadLinkBloc({required String link}) {
    _downloadLinkController =
        StreamController<ApiResponse<List<NameLinkModel>>>();
    _downloadLinkRepository = NameLinkRepository();
    fetchDownloadLinks(link: link);
  }

  fetchDownloadLinks({required String link}) async {
    downloadLinkSink.add(ApiResponse.loading('Fetching download links'));
    try {
      List<NameLinkModel> links =
          await _downloadLinkRepository.fetchDownloadLink(link: link);
      downloadLinkSink.add(ApiResponse.completed(links));
    } catch (e) {
      downloadLinkSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _downloadLinkController.close();
  }
}
