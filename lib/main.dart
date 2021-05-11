import 'package:anime_downloader/api_service.dart';
import 'package:flutter/material.dart';


void main(){
  API_Service service = API_Service();
  service.search(name: 'World trigger');
  service.results();
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
