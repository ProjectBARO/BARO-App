import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../models/video.dart';

class VideoNotifier extends StateNotifier<Video> {
  VideoNotifier() : super(Video(alertCount: 0, analysisTime: 0, type: '', videoUrl: ''));

  Future<void>? _processing;

  final storage = const FlutterSecureStorage();

  @override
  void dispose() {
    if (_processing != null) {
      _processing!.then((_) => super.dispose());
    } else {
      super.dispose();
    }
  }

  Future<void> setVideoUrl(String url) async {
    state = state.copyWith(videoUrl: url);
  }

  void setAlertCount(int count) {
    state = state.copyWith(alertCount: count);
  }

  void setAnalysisTime(String path) {
    _getVideoLength(path).then((value) => state = state.copyWith(analysisTime: value));
  }

  void setType(String type) {
    state = state.copyWith(type: type);
  }

  Future<int> _getVideoLength(String path) async {
    final videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    Duration length = videoPlayerController.value.duration;
    await videoPlayerController.dispose();

    return length.inSeconds;
  }

  void setVideoInfo(String url) {
    _processing = setVideoUrl(url);
  }

  Future<void> uploadVideoInfo() async {
    String? accessToken = await storage.read(key: 'accessToken');
    final response = await http.post(
      Uri.parse('${dotenv.get('SERVER_URL')}/analysis'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(state.toJson()),
    );

    log(jsonEncode(state.toJson()));
    log(response.body);

    if (response.statusCode == 200) {
      log('전송 성공');
    } else {
      log('전송 실패: ${response.statusCode.toString()}');
    }
  }
}

final videoProvider = StateNotifierProvider<VideoNotifier, Video>((ref) => VideoNotifier());
