import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloaderWebView extends StatefulWidget {
  final String link;

  const DownloaderWebView({Key key, this.link}) : super(key: key);

  @override
  _DownloaderWebViewState createState() => _DownloaderWebViewState();
}

class _DownloaderWebViewState extends State<DownloaderWebView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
