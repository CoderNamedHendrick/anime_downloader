import 'package:anime_downloader/services/api_service.dart';
import 'package:flutter/material.dart';


void main(){
  API_Service service = API_Service();
  // service.search(name: 'world trigger');
  // service.desc(link: '/category/world-trigger-dub');
  // service.episodes(start: '1', end: '12', id: '8933');
  service.downloadLink(link: '/world-trigger-dub-episode-2');
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(color: Colors.red,),
    );
  }
}
