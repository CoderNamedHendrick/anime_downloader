import 'package:anime_downloader/screens/desc_screen.dart';
import 'package:anime_downloader/screens/download_screen.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/screens/search.dart';
import 'package:anime_downloader/screens/search_screen.dart';
import 'package:flutter/material.dart';


void main(){

   // Future<List<Search>> result = ApiService.instance.search(name: 'world trigger');
   // result.then((value) {
   //   List<Search> search = value.toList();
   //   for(int i = 0; i<search.length; i++){
   //     print(search[i].name);
   //     print(search[i].link);
   //   }
   // });
  // Future<Desc> description = ApiService.instance.desc(link: '/category/world-trigger-dub');
  // description.then((value) {
  //   Desc desc = value;
  //   print(desc.name);
  //   print(desc.summary);
  //   print(desc.genre);
  // });
  // Future<List<Episodes>> result = ApiService.instance.episodes(start: '1', end: '12', id: '8933');
  //  result.then((value) {
  //    List<Episodes> search = value.toList();
  //    for(int i = 0; i<search.length; i++){
  //      print(search[i].name);
  //      print(search[i].link);
  //    }
  //  });
  // Future<List<DownloadLink>> result = ApiService.instance.downloadLink(link: '/world-trigger-dub-episode-2');
  // result.then((value) {
  //   List<DownloadLink> search = value.toList();
  //   for(int i = 0; i<search.length; i++){
  //     print(search[i].name);
  //     print(search[i].link);
  //   }
  // });
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
