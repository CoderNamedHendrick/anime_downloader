import 'package:anime_downloader/blocs/download_links_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/screens/home/download_webview.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key, this.title, this.name, this.link})
      : super(key: key);
  final String link;
  final String title;
  final String name;

  static Future<void> show(BuildContext context,
      {String link, String title, String name}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DownloadScreen(
          link: link,
          title: title,
          name: name,
        ),
      ),
    );
  }

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  DownloadLinkBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DownloadLinkBloc(link: widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDownloadLinks(link: widget.link),
        child: StreamBuilder<ApiResponse<List<NameLinkModel>>>(
          stream: _bloc.downloadLinkStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Downloads(
                    animeTitle: widget.title,
                    episode: widget.name,
                    downloads: snapshot.data.data,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _bloc.fetchDownloadLinks(link: widget.link),
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
}

class Downloads extends StatelessWidget {
  const Downloads({Key key, this.animeTitle, this.episode, this.downloads})
      : super(key: key);
  final List<NameLinkModel> downloads;
  final String animeTitle;
  final String episode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: downloads.length,
      itemBuilder: (context, index) => _episodes(
        context,
        animeTitle: animeTitle,
        episode: episode,
        name: downloads[index].name,
        link: downloads[index].link,
      ),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

Widget _episodes(BuildContext context,
    {String animeTitle, String episode, String name, String link}) {
  return ListTile(
    title: Text('$name', style: TextStyle(color: Colors.white)),
    trailing: Icon(Icons.arrow_downward_sharp, color: Colors.white),
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DownloaderWebView(
          animeTitle: animeTitle,
          episode: episode,
          link: link,
        ),
      ),
    ),
  );
}
