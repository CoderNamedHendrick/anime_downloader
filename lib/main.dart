import 'package:anime_downloader/services/api_service.dart';
import 'package:flutter/material.dart';


void main(){
  API_Service service = API_Service();
  // service.search(name: 'world trigger');
  service.desc(link: '/category/world-trigger-2nd-season');
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
