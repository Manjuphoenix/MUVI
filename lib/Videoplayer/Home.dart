import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muvi/Videoplayer/player_screen.dart';
import 'package:muvi/models/Channel_info.dart';
import 'package:muvi/models/Videos_list.dart';
import 'package:muvi/utils/Services.dart';
//import 'package:muvi/main.dart';

class VideHome extends StatefulWidget {
  @override
  _VideHomeState createState() => _VideHomeState();
}

class _VideHomeState extends State<VideHome> {

  ChannelInfo _channelInfo;
  Item _item;
  bool _loading;
  String _playlistId;
  VideosList _videosList;
  String _nextpageToken;
  ScrollController _scrollController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _loading = true;
    _videosList = VideosList();
    _videosList.videos = List();
    _nextpageToken = '';
    _getChannelInfo();
  }

  _getChannelInfo()async{
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playlistId = _item.contentDetails.relatedPlaylists.uploads;
    //print('_playlistID $_playlistId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos()async{
    VideosList tempVideoList = await Services.getVideosList(
      playListId: _playlistId,
      pageToken: _nextpageToken,
    );
  _nextpageToken = tempVideoList.nextPageToken;
  _videosList.videos.addAll(tempVideoList.videos);
  //print('Videos: ${_videosList.videos}');
  setState(() {  });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('YouTube'),
      ),
      body: Container(
        child: Column(children: [
          _buildInfoView(),
          Expanded(
            
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollEndNotification notification){
                if(notification.metrics.pixels == notification.metrics.maxScrollExtent){
                  _loadVideos();
                }
                return true;
              },
                          child: ListView.builder(
                controller: _scrollController,
                itemCount: _videosList.videos.length,
                itemBuilder: (context, index){
                  VideoItem videoItem = _videosList.videos[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoItem: videoItem,)));
                    },
                                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: videoItem.video.thumbnails.thumbnailsDefault.url,
                            ),
                            SizedBox(width: 15,),
                            Flexible(child: Text(videoItem.video.title)),
                            SizedBox(width: 15,)
                          ],
                        ),
                      )
                    ),
                  );
              }),
            ),
          )
        ],),
      ),
    );
  }
  _buildInfoView(){
  return _loading ? CircularProgressIndicator() : Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(_item.snippet.thumbnails.medium.url),
              ),
              SizedBox(width: 20,),
              Expanded(child: Text('AstroAJ', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20))),
              /*Text(
                _item.statistics.videoCount
              )*/
            ],
          ),
        ),
      ),
    ),
  );
  }
}