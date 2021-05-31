import 'package:anime_downloader/screens/video_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  final file;
  const VideoScreen({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Video Player Demo'),
        centerTitle: true,
      ),
      body: VideoView(
        videoPlayerController: VideoPlayerController.file(this.file),
        looping: true,
        autoplay: true,
      ),
    );
  }
}
