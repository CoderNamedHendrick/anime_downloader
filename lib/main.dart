import 'package:anime_downloader/screens/desc_screen.dart';
import 'package:anime_downloader/screens/download_screen.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/screens/search.dart';
import 'package:anime_downloader/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug:true
  );
  await Permission.storage.request();
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
