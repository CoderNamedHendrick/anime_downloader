import 'dart:io';

import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class FolderContents extends StatefulWidget {
  final String dir;
  const FolderContents({Key key, this.dir}) : super(key: key);

  @override
  _FolderContentsState createState() => _FolderContentsState();
}

class _FolderContentsState extends State<FolderContents> {
  List files;

  @override
  void initState() {
    super.initState();
    print(widget.dir);
    _listFiles();
  }

  void _listFiles() async {
    final dir = await Directory(widget.dir);
    setState(() {
      files = dir.listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: files == null
          ? Loading(
              loadingMessage: 'Fetching Episodes',
            )
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(
                    '${files[index].path}'
                        .replaceAll("${widget.dir}/", ""),
                  ),
                  leading: Icon(Icons.play_circle_outline_sharp),
                  trailing: Icon(Icons.chevron_right_sharp),
                ),
              ),
            ),
    );
  }
}
