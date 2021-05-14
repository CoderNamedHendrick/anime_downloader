import 'package:anime_downloader/blocs/episode_bloc.dart';
import 'package:anime_downloader/common_widgets/episodes.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/episodes_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:flutter/material.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({Key key, this.start, this.end, this.id, this.name})
      : super(key: key);

  final String start;
  final String end;
  final String id;
  final String name;

  @override
  _EpisodesScreenState createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  EpisodeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = EpisodeBloc(
      start: widget.start,
      end: widget.end,
      id: widget.id,
      name: widget.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchEpisodes(
          start: widget.start,
          end: widget.end,
          id: widget.id,
          name: widget.name,
        ),
        child: StreamBuilder<ApiResponse<List<EpisodeModel>>>(
          stream: _bloc.episodeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Episodes(
                    episodeList: snapshot.data.data,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchEpisodes(
                      start: widget.start,
                      end: widget.end,
                      id: widget.id,
                      name: widget.name,
                    ),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose(){
    _bloc.dispose();
    super.dispose();
  }
}

class Episodes extends StatelessWidget {
  const Episodes({Key key, this.episodeList}) : super(key: key);
  final List<EpisodeModel> episodeList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: episodeList.length,
      itemBuilder: (context, index) => EpisodesWidget(
        context,
        name: episodeList[index].name,
        link: episodeList[index].link,
      ),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
