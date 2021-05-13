
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

  fetchDownloadLinks(String link){
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