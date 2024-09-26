import 'package:baro_project/service/proto/video/video.pb.dart';

class YoutubeVideo {
  String id;
  String thumbnailUrl;
  String title;
  String category;

  YoutubeVideo({
    required this.id,
    required this.thumbnailUrl,
    required this.title,
    required this.category,
  });

  static YoutubeVideo fromProto(VideoMessage proto) {
    return YoutubeVideo(
      id: proto.videoId,
      thumbnailUrl: proto.thumbnailUrl,
      title: proto.title,
      category: proto.category,
    );
  }
}  
