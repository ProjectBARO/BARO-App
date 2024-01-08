import 'package:camera/camera.dart';

class CameraState {
  CameraController? controller;
  Future<void>? initializeControllerFuture;
  bool isRecording = false;
  String? videoPath;
  bool isCompressing = false;
  bool isUploading = false;

  CameraState({
    this.controller,
    this.initializeControllerFuture,
    this.isRecording = false,
    this.videoPath,
    this.isCompressing = false,
    this.isUploading = false,
  });

  CameraState copyWith({
    CameraController? controller,
    Future<void>? initializeControllerFuture,
    bool? isRecording,
    String? videoPath,
    bool? isCompressing,
    bool? isUploading,
  }) {
    return CameraState(
      controller: controller ?? this.controller,
      initializeControllerFuture: initializeControllerFuture ?? this.initializeControllerFuture,
      isRecording: isRecording ?? this.isRecording,
      videoPath: videoPath ?? this.videoPath,
      isCompressing: isCompressing ?? this.isCompressing,
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
