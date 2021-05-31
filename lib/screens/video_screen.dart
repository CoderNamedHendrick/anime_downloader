import 'dart:io';
import 'package:anime_downloader/screens/video_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as p;

class VideoScreen extends StatelessWidget {
  final file;
  const VideoScreen({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Extension: ${p.extension(this.file)}");
    print("Checking if file exits: ${File(this.file).existsSync()}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Video Player Demo'),
        centerTitle: true,
      ),
      body: VideoView(
        videoPlayerController: VideoPlayerController.file(File(this.file)),
        looping: true,
        autoplay: true,
      ),
    );
  }
}
