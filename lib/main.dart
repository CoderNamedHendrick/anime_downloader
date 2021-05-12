import 'package:anime_downloader/services/api_service.dart';
import 'package:flutter/material.dart';


void main(){
  API_Service service = API_Service();
  // service.search(name: 'world trigger');
  // service.desc(link: '/category/world-trigger-2nd-season');
  // service.episodes(start: '1', end: '12', id: '10016');
  service.downloadLink(link: '/world-trigger-2nd-season-episode-2');
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
