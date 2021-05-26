import 'package:anime_downloader/screens/desc_screen.dart';
import 'package:anime_downloader/screens/download_screen.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/screens/home_screen.dart';
import 'package:anime_downloader/screens/search.dart';
import 'package:anime_downloader/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  await Permission.storage.request();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pōtaru',
      theme: ThemeData(
          primaryColor: const Color(0xff282828),
          accentColor: const Color(0x00282828),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600))),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Search(),
      //   '/search': (context) => SearchScreen(),
      //   '/description': (context) => DescriptionScreen(),
      //   '/episodes': (context) => EpisodesScreen(),
      //   '/download_links': (context) => DownloadScreen(),
      // },
      home: Search(),
    );
  }
}
