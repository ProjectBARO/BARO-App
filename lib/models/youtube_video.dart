import 'package:baro_project/service/video/video.pb.dart';

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

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      id: json['video_id'] as String? ?? "",
      thumbnailUrl: json['thumbnail_url'] as String? ?? "",
      title: json['title'] as String? ?? "",
      category: json['category'] as String? ?? "",
    );
  }

  static YoutubeVideo fromProto(VideoMessage proto) {
    return YoutubeVideo(
      id: proto.videoId,
      thumbnailUrl: proto.thumbnailUrl,
      title: proto.title,
      category: proto.category,
    );
  }
}  
