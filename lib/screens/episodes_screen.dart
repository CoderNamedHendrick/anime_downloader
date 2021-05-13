import 'package:anime_downloader/screens/download_screen.dart';
import 'package:flutter/material.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes'),
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => _episodes(context),
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

Widget _episodes(BuildContext context) {
  return ListTile(
    title: Text('Episode ##'),
    trailing: Icon(Icons.chevron_right),
    onTap: () => Navigator.of(context).pushNamed(
      '/download_links'
    ),
  );
}
