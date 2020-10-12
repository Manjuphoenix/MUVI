import 'dart:io';

import 'package:http/http.dart';
import 'package:muvi/models/Channel_info.dart';
import 'package:muvi/models/Videos_list.dart';
import 'package:muvi/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services{
  //
  static const CHANNEL_ID = 'UCE2Nbnk5ydUOdoScK-wL5oQ';
  static const _baseUrl = 'www.googleapis.com';

static Future<ChannelInfo> getChannelInfo()async{
  Map<String, String> parameters = {
    'part' : 'snippet,contentDetails,statistics',
    'id' : CHANNEL_ID,
    'key' : Constants.API_Key,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader:'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
    Response response = await http.get(uri, headers: headers);
    //print(response.body);
  ChannelInfo channelInfo =  channelInfoFromJson(response.body);
  return channelInfo;
}
static Future<VideosList> getVideosList({String playListId, String pageToken})async{
Map<String, String> parameters = {
 'part': 'snippet',
 'playlistId': playListId,
  'maxResults': '5',
  'pageToken': pageToken, 
  'key': Constants.API_Key,
};
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader:'application/json',
  };
  Uri uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);
  Response response = await http.get(uri, headers: headers);
  //print(response.body);
  VideosList videosList = videosListFromJson(response.body);
  return videosList;
}

}