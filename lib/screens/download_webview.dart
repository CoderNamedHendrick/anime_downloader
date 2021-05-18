import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloaderWebView extends StatefulWidget {
  final String link;

  const DownloaderWebView({Key key, this.link}) : super(key: key);

  @override
  _DownloaderWebViewState createState() => _DownloaderWebViewState();
}

class _DownloaderWebViewState extends State<DownloaderWebView> {
  InAppWebViewController webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.link),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useOnDownloadStart: true,

          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
        },
        onLoadStart: (InAppWebViewController controller, Uri url) {},
        onLoadStop: (InAppWebViewController controller, Uri url) {},
        onDownloadStart: (controller, url) async {
          print("OnDownloadStart $url");
          final taskId = await FlutterDownloader.enqueue(
            savedDir: (await getExternalStorageDirectory()).path,
            showNotification: true,
            openFileFromNotification: true,
          );
        },
      ),
    );
  }
}
