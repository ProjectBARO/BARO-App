import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:baro_project/provider/classify_provider.dart';
import 'package:baro_project/service/image_converter.dart';
import 'package:baro_project/service/video_compressor.dart';
import 'package:baro_project/service/video_uploader.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import '../models/camera.dart';
import 'timer_provider.dart';

final cameraProvider = StateNotifierProvider<CameraNotifier, CameraState>((ref) => CameraNotifier(
    videoCompressor: VideoCompressor(),
    videoUploader: VideoUploader(),
    screenshotController: ref.watch(screenshotProvider)));
final pauseProvider = StateProvider<bool>((ref) => false);
final screenshotProvider = Provider<ScreenshotController>((ref) => ScreenshotController());

class CameraNotifier extends StateNotifier<CameraState> with WidgetsBindingObserver {
  final VideoCompressor videoCompressor;
  final VideoUploader videoUploader;
  final ScreenshotController screenshotController;

  CameraNotifier({required this.videoCompressor, required this.videoUploader, required this.screenshotController})
      : super(CameraState()) {
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  List<CameraDescription>? cameras;

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _setCamera(cameras![0]);
  }

  Future<void> _disposeController() async {
    if (state.controller == null) return;
    final cameraController = state.controller;
    state = state.copyWith(controller: null);
    await cameraController!.dispose();
  }

  Future<void> _setCamera(CameraDescription cameraDescription) async {
    if (state.controller != null) {
      await state.controller!.dispose();
    }

    CameraController controller = CameraController(
      cameraDescription,
      ResolutionPreset.low,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      state = state.copyWith(controller: controller);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> startStopRecording(WidgetRef ref, BuildContext context) async {
    final timer = ref.watch(timerProvider.notifier);
    if (state.isRecording) {
      XFile videoFile = await state.controller!.stopVideoRecording();
      String videoPath = videoFile.path;
      _processingVideo(videoPath).then((result) {
        if (result) {
          log("동영상 처리 완료");
        } else {
          log("동영상 처리 실패");
        }
      });
      if (mounted) {
        context.go('/result');
      }
      state = state.copyWith(isRecording: false, videoPath: videoPath);
    } else {
      timer.startTimer();
      await Future.delayed(const Duration(seconds: 10));
      await state.controller!.startVideoRecording();
      state = state.copyWith(isRecording: true);

      Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (!state.isRecording) {
          timer.cancel();
        } else {
          screenshotController.capture().then((capturedImage) {
            Float32List imgData = ImageConverter.convertImage(capturedImage!);
            ref.watch(classifyProvider.notifier).predict(imgData);
          });
        }
      });
    }
  }

  Future<bool> _processingVideo(String videoPath) async {
    String compressedVideoPath = await _compressVideo(videoPath);
    if (compressedVideoPath.isEmpty) {
      log("압축 실패");
      return false;
    }
    bool uploadResult = await _uploadVideo(compressedVideoPath);
    if (!uploadResult) {
      log("업로드 실패");
      return false;
    }
    return true;
  }

  Future<String> _compressVideo(String videoPath) async {
    try {
      state = state.copyWith(isCompressing: true);
      final result = await videoCompressor.compressVideo(videoPath);
      state = state.copyWith(isCompressing: false);
      return result!.path!;
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  Future<bool> _uploadVideo(String videoPath) async {
    try {
      state = state.copyWith(isUploading: true);
      await videoUploader.uploadVideo(videoPath);
      state = state.copyWith(isUploading: false);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> pauseResumeRecording(WidgetRef ref) async {
    final pauseController = ref.watch(pauseProvider.notifier);
    if (pauseController.state) {
      await state.controller!.resumeVideoRecording();
    } else {
      await state.controller!.pauseVideoRecording();
    }
    pauseController.state = !pauseController.state;
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;
    CameraDescription newCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection != state.controller!.description.lensDirection,
        orElse: () => cameras!.first);
    _setCamera(newCamera);
  }

  @override
  void dispose() {
    _disposeController();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (AppLifecycleState.paused == state) {
      _disposeController();
    } else {
      if (this.state.controller == null) {
        _initCamera();
      }
    }
  }
}
