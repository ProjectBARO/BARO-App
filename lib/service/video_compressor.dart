import 'package:video_compress/video_compress.dart';

class VideoCompressor {
  Future<MediaInfo?> compressVideo(
    String path, {
    VideoQuality quality = VideoQuality.MediumQuality,
    bool deleteOrigin = true,
  }) {
    return VideoCompress.compressVideo(path, quality: quality, deleteOrigin: deleteOrigin);
  }
}