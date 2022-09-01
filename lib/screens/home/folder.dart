import 'dart:io';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class FolderContents extends StatefulWidget {
  final String dir;
  const FolderContents({super.key, required this.dir});

  @override
  _FolderContentsState createState() => _FolderContentsState();
}

class _FolderContentsState extends State<FolderContents> {
  List? files;

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
      appBar: AppBar(
        title: Text(
          'Episodes',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: files == null
          ? Loading(
              loadingMessage: 'Fetching Episodes',
            )
          : ListView.builder(
              itemCount: files?.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                    title: Text(
                      '${files?[index]?.path}'.replaceAll("${widget.dir}/", ""),
                    ),
                    leading: Icon(Icons.play_circle_outline_sharp),
                    trailing: Icon(Icons.chevron_right_sharp),
                    onTap: () {
                      print(files?[index]?.path);
                      try {
                        OpenFile.open(files?[index]?.path, type: "video/mp4");
                      } catch (e){
                        print(e);
                      }
                    }),
              ),
            ),
    );
  }
}
