import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:baro_project/provider/classifier_provider.dart';
import 'package:baro_project/provider/video_provider.dart';
import 'package:baro_project/service/image_converter.dart';
import 'package:baro_project/service/video_compressor.dart';
import 'package:baro_project/service/video_uploader.dart';
import 'package:baro_project/widgets/loading_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import '../models/camera.dart';
import 'timer_provider.dart';

final cameraProvider = StateNotifierProvider.autoDispose<CameraNotifier, CameraState>((ref) => CameraNotifier(
    videoCompressor: VideoCompressor(),
    videoUploader: VideoUploader(),
    screenshotController: ref.watch(screenshotProvider)));
final pauseProvider = StateProvider<bool>((ref) => false);
final screenshotProvider = Provider<ScreenshotController>((ref) => ScreenshotController());

class CameraNotifier extends StateNotifier<CameraState> with WidgetsBindingObserver {
  final VideoCompressor videoCompressor;
  final VideoUploader videoUploader;
  final ScreenshotController screenshotController;
  Timer? captureTimer;

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
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      state = state.copyWith(controller: controller);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _disposeController();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final CameraController? cameraController = this.state.controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      await _disposeController();
    }
    if (state == AppLifecycleState.resumed) {
      await _setCamera(cameraController.description);
    }
  }

  Future<void> startStopRecording(WidgetRef ref, BuildContext context) async {
    if (state.isRecording) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => loadingDialog());
      _stopRecording(ref).then((_) {
        _setVideo(ref).then((_) {
          context.go('/result');
        });
      });
    } else {
      await _startRecording(ref);
    }
  }

  Future<void> _startRecording(WidgetRef ref) async {
    ref.watch(timerProvider.notifier).startTimer();
    await Future.delayed(const Duration(seconds: 10));
    await state.controller!.startVideoRecording();
    state = state.copyWith(isRecording: true);
    _captureController(true, ref);
  }

  Future<void> _stopRecording(WidgetRef ref) async {
    XFile videoFile = await state.controller!.stopVideoRecording();
    _captureController(false, ref);
    state = state.copyWith(isRecording: false, videoPath: videoFile.path);
  }

  Future<void> _setVideo(WidgetRef ref) async {
    final classifier = ref.read(classifierProvider.notifier);
    final video = ref.read(videoProvider.notifier);
    video.setAnalysisTime(state.videoPath!);
    video.setAlertCount(classifier.state.alertCount);
    bool result = await _processVideo(state.videoPath!);
    if (result) {
      await Future(() async {
        video.setVideoInfo(state.videoUrl!);
        await video.uploadVideoInfo();
      });
    }
  }

  void _captureController(bool isStart, WidgetRef ref) {
    final classifier = ref.read(classifierProvider.notifier);
    if (isStart) {
      captureTimer = Timer.periodic(const Duration(seconds: 30), (timer) async {
        if (!state.isRecording) {
          timer.cancel();
        } else {
          screenshotController.capture().then((capturedImage) {
            Float32List imgData = ImageConverter.convertImage(capturedImage!);
            classifier.predict(imgData);
          });
        }
      });
    } else {
      captureTimer?.cancel();
    }
  }

  Future<bool> _processVideo(String videoPath) async {
    // String compressedVideoPath = await _compressVideo(videoPath);
    // if (compressedVideoPath.isEmpty) {
    //   log("압축 실패");
    //   return false;
    // }
    // bool uploadResult = await _uploadVideo(compressedVideoPath);
    bool uploadResult = await _uploadVideo(videoPath);
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
      String url = await videoUploader.uploadVideo(videoPath);
      state = state.copyWith(isUploading: false, videoUrl: url);
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
      _captureController(true, ref);
    } else {
      await state.controller!.pauseVideoRecording();
      _captureController(false, ref);
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
}
