import 'package:anime_downloader/screens/desc_screen.dart';
import 'package:anime_downloader/screens/download_screen.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/screens/search.dart';
import 'package:anime_downloader/screens/search_screen.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pōtaru',
      initialRoute: '/',
      routes: {
        '/': (context) => Search(),
        '/search': (context) => SearchScreen(),
        '/description': (context) => DescriptionScreen(),
        '/episodes': (context) => EpisodesScreen(),
        '/download_links': (context) => DownloadScreen(),
      },
    );
  }
}
