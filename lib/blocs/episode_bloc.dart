
class EpisodeBloc{
  EpisodeRepository _episodeRepository;
  StreamController _episodeController;

  StreamSink<ApiResponse<List<EpisodeModel>>> get episodeSink => _episodeController.sink;

  Stream<ApiResponse<List<EpisodeModel>>> get episodeStream => _episodeController.stream;

  EpisodeBloc({String start, String end, String id}){
    _episodeController = StreamController<ApiResponse<List<EpisodeModel>>>();
    _episodeRepository = EpisodeRepository();
    fetchEpisodes(start, end, id);
  }

  fetchEpisodes(String start, String end, String id){
    episodeSink.add(ApiResponse.loading('Fetching Episodes'));
    try{
      List<EpisodeModel> episodes = await _episodeRepository.fetchEpisodes(start: start, end: end, id: id);
      episodeSink.add(ApiResponse.completed(episodes));
    } catch(e){
      episodeSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose(){
    _episodeController.close();
  }
}