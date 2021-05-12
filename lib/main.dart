import 'package:anime_downloader/screens/desc_screen.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/screens/search_page.dart';
import 'package:anime_downloader/services/api_service.dart';
import 'package:anime_downloader/services/desc_json_to_dart.dart';
import 'package:anime_downloader/services/download_links_json_to_dart.dart';
import 'package:anime_downloader/services/episodes_json_to_dart.dart';
import 'package:anime_downloader/services/search_json_to_dart.dart';
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
      home: EpisodesScreen(),
    );
  }
}
