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
}  
