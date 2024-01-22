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
  ImageConverter converter = ImageConverter();

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
    );

    try {
      await controller.initialize();
      state = state.copyWith(controller: controller);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> startStopRecording(WidgetRef ref) async {
    final timer = ref.watch(timerProvider.notifier);
    if (state.isRecording) {
      XFile videoFile = await state.controller!.stopVideoRecording();
      String videoPath = videoFile.path;
      state = state.copyWith(isCompressing: true);
      final result = await videoCompressor.compressVideo(videoPath);
      videoPath = result!.path!;
      state = state.copyWith(isCompressing: false, isUploading: true);
      await videoUploader.uploadVideo(result.path!);
      state = state.copyWith(isRecording: false, videoPath: videoPath, isUploading: false);
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
            Float32List imgData = converter.convertImage(capturedImage!);
            ref.watch(classifyProvider.notifier).predict(imgData);
          });
        }
      });
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
