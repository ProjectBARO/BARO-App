import 'package:camera/camera.dart';

class CameraState {
  CameraController? controller;
  Future<void>? initializeControllerFuture;
  bool isRecording = false;
  String? videoPath;
  bool isCompressing = false;
  bool isUploading = false;
  String? videoUrl;

  CameraState({
    this.controller,
    this.initializeControllerFuture,
    this.isRecording = false,
    this.videoPath,
    this.isCompressing = false,
    this.isUploading = false,
    this.videoUrl,
  });

  CameraState copyWith({
    CameraController? controller,
    Future<void>? initializeControllerFuture,
    bool? isRecording,
    String? videoPath,
    bool? isCompressing,
    bool? isUploading,
    String? videoUrl,
  }) {
    return CameraState(
      controller: controller ?? this.controller,
      initializeControllerFuture: initializeControllerFuture ?? this.initializeControllerFuture,
      isRecording: isRecording ?? this.isRecording,
      videoPath: videoPath ?? this.videoPath,
      isCompressing: isCompressing ?? this.isCompressing,
      isUploading: isUploading ?? this.isUploading,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
