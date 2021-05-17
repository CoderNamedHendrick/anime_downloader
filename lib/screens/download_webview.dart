import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DownloaderWebview extends StatelessWidget {
  final String link;

  const DownloaderWebview({Key key, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: this.link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
