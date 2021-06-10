import 'package:anime_downloader/screens/download_screen.dart';
import 'package:flutter/material.dart';

Widget EpisodesWidget(BuildContext context,
    {String title, String name, String link}) {
  return ListTile(

    title: Text('$name', style: TextStyle(color: Colors.white)),
    trailing: Icon(Icons.chevron_right, color: Colors.white),
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DownloadScreen(
          title: title,
          name: name,
          link: link,
        ),
      ),
    ),
  );
}
