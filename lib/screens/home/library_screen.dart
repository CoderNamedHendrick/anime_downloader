import 'dart:io';

import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/screens/home/folder.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List folders;

  @override
  void initState() {
    super.initState();
    _listFolders();
  }

  void _listFolders() async {
    final directoryName = 'Pōtaru';
    final dir = await Directory('storage/emulated/0/$directoryName');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await dir.exists() == false) {
      await dir.create(recursive: true);
    }

    setState(() {
      folders = dir.listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library', style: Theme.of(context).textTheme.headline1,),
      ),
      body: folders == null
          ? Loading(
              loadingMessage: 'Fetching Folders',
            )
          : ListView.builder(
              itemCount: folders.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(
                    '${folders[index].path}'
                        .replaceAll("storage/emulated/0/Pōtaru/", ""),
                  ),
                  leading: Icon(Icons.folder),
                  trailing: Icon(Icons.chevron_right_sharp),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FolderContents(
                        dir: folders[index].path,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
