import 'dart:convert';
import 'package:baro_project/models/youtube_video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class YoutubeService {
  Future<List<YoutubeVideo>> fetchVideos() async {
    var response = await http.get(Uri.parse('${dotenv.get('SERVER_URL')}/videos'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<YoutubeVideo> videos = (data as List).map((i) => YoutubeVideo.fromJson(i)).toList();
      return videos;
    } else {
      throw Exception('Failed to load videos: ${response.statusCode}');
    }
  }

  void launchYoutubeVideo(String id) {
    launchUrl(Uri.parse('https://www.youtube.com/watch?v=$id'));
  }
}
