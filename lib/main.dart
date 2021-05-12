import 'package:anime_downloader/services/api_service.dart';
import 'package:flutter/material.dart';


void main(){

  // ApiService.instance.search(name: 'world trigger');
  // ApiService.instance.desc(link: '/category/world-trigger-dub');
  // ApiService.instance.episodes(start: '1', end: '12', id: '8933');
  ApiService.instance.downloadLink(link: '/world-trigger-dub-episode-2');
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
