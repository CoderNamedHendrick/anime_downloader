import 'package:anime_downloader/blocs/episode_bloc.dart';
import 'package:anime_downloader/common_widgets/episodes.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/name_link_model.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchEpisodes(
          start: widget.start,
          end: widget.end,
          id: widget.id,
          name: widget.name,
        ),
        child: StreamBuilder<ApiResponse<List<NameLinkModel>>>(
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
                    title: widget.name,
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
  const Episodes({Key key, this.episodeList, this.title}) : super(key: key);
  final List<NameLinkModel> episodeList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: episodeList.length,
      itemBuilder: (context, index) => EpisodesWidget(
        context,
        title: title,
        name: episodeList[index].name,
        link: episodeList[index].link,
      ),
    );
  }
}