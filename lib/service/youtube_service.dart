import 'dart:convert';
import 'dart:developer';
import 'package:baro_project/models/youtube_video.dart';
import 'package:baro_project/service/video/video.pbgrpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class YoutubeService {
  Future<List<YoutubeVideo>> fetchVideos() async {
    // var response = await http.get(Uri.parse('${dotenv.get('SERVER_URL')}/videos'));

    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body)['data'];
    //   List<YoutubeVideo> videos = (data as List).map((i) => YoutubeVideo.fromJson(i)).toList();
    //   return videos;
    // } else {
    //   throw Exception('Failed to load videos: ${response.statusCode}');
    // }

    final channel = ClientChannel(
      dotenv.get('PROTO_URL'),
      // options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final stub = VideoServiceClient(channel);

    try {
      final request = GetVideosRequest();
      final response = await stub.getVideos(request);

      final List<YoutubeVideo> videos =
          response.videos.map((videoMessage) => YoutubeVideo.fromProto(videoMessage)).toList();
      return videos;
    } catch (e) {
      log(e.toString());
      throw Exception('동영상 로드 실패');
    } finally {
      await channel.shutdown();
    }
  }

  void launchYoutubeVideo(String id) {
    launchUrl(Uri.parse('https://www.youtube.com/watch?v=$id'));
  }
}
