import 'dart:developer';
import 'package:baro_project/models/youtube_video.dart';
import 'package:baro_project/service/proto/video/video.pbgrpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeService {
  Future<List<YoutubeVideo>> fetchVideos() async {
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
