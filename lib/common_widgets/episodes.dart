import 'package:anime_downloader/screens/download_screen.dart';
import 'package:flutter/material.dart';

Widget EpisodesWidget(BuildContext context, {String name, String link}) {
  return ListTile(
    title: Text('$name'),
    trailing: Icon(Icons.chevron_right),
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DownloadScreen(
          link: link,
        ),
      ),
    ),
  );
}
