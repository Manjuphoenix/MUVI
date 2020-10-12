import 'package:flutter/material.dart';
import 'package:muvi/models/Videos_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
 //
  VideoPlayerScreen({this.videoItem});
  final VideoItem videoItem;


  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;
  bool _isplayerReady;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isplayerReady = false;
    _controller = YoutubePlayerController(initialVideoId: widget.videoItem.video.resourceId.videoId, flags: YoutubePlayerFlags(mute: false, autoPlay: true))..addListener(() {_listener;});
  }

  void _listener(){
    if(_isplayerReady && mounted && !_controller.value.isFullScreen){
      //
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoItem.video.title),
      ),
      body: Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: (){
            //print('Player ready');
            _isplayerReady = true;
          },
        ),
      ),
    );
  }
}