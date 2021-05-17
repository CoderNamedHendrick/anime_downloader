import 'package:anime_downloader/blocs/download_links_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/download_links_model.dart';
import 'package:anime_downloader/screens/download_webview.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key key, this.link}) : super(key: key);
  final String link;

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
        title: Text('Download links'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDownloadLinks(link: widget.link),
        child: StreamBuilder<ApiResponse<List<DownloadLinkModel>>>(
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
  const Downloads({Key key, this.downloads}) : super(key: key);
  final List<DownloadLinkModel> downloads;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: downloads.length,
      itemBuilder: (context, index) => _episodes(
        context,
        name: downloads[index].name,
        link: downloads[index].link,
      ),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

Widget _episodes(BuildContext context, {String name, String link}) {
  return ListTile(
    title: Text('$name'),
    trailing: Icon(Icons.download_outlined),
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DownloaderWebView(link: link,),
      ),
    ),
  );
}
