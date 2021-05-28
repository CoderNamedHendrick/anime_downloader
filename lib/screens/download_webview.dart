import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloaderWebView extends StatefulWidget {
  final String link;
  final String animeTitle;
  final String episode;

  const DownloaderWebView({Key key, this.animeTitle, this.episode, this.link})
      : super(key: key);

  @override
  _DownloaderWebViewState createState() => _DownloaderWebViewState();
}

class _DownloaderWebViewState extends State<DownloaderWebView> {
  int progress = 0;
  ReceivePort _receivePort = ReceivePort();

  createDir() async {
    final directoryName = 'Pōtaru';
    final myDir =
        Directory('storage/emulated/0/$directoryName/${widget.animeTitle}');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await myDir.exists()) {
      print(myDir.path);
      return myDir;
    }

    final dir = await myDir.create(recursive: true);
    print(dir.path);
    return dir;
  }

  static downloadingCallback(id, status, progress) {
    final SendPort sendPort =
        IsolateNameServer.lookupPortByName('downloading_send_port');
    sendPort.send([id, status, progress]);
  }

  InAppWebViewController webViewController;

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading_send_port");

    // listening for the data coming from the download isolate
    _receivePort.listen((message) {
      String id = message[0];
      DownloadTaskStatus status = message[1];
      progress = message[2];
      setState(() {});
      print(progress);
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloading_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress: $progress"),
      ),
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
          // final externalDir = await getExternalStorageDirectory();
          final externalDir = await createDir();

          final taskId = await FlutterDownloader.enqueue(
            url: url.toString(),
            savedDir: externalDir.path,
            fileName: "${widget.episode}",
            showNotification: true,
            openFileFromNotification: true,
          );
        },
      ),
    );
  }
}
