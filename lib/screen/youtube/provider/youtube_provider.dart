import 'package:baro_project/model/youtube_video.dart';
import 'package:baro_project/screen/youtube/util/youtube_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeServiceProvider = Provider<YoutubeService>((ref) => YoutubeService());

final youtubeProvider = FutureProvider<List<YoutubeVideo>>((ref) {
  final youtubeService = ref.read(youtubeServiceProvider);
  return youtubeService.fetchVideos();
});
