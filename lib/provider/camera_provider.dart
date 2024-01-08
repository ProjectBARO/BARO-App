import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import '../models/camera.dart';

final cameraProvider = StateNotifierProvider<CameraProvider, CameraState>((ref) => CameraProvider());
final timerProvider = StateProvider<int>((ref) => 0);
final pauseProvider = StateProvider<bool>((ref) => false);

class CameraProvider extends StateNotifier<CameraState> {
  CameraProvider() : super(CameraState()) {
    _initCamera();
  }

  List<CameraDescription>? cameras;

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _setCamera(cameras!.first);
  }

  Future<void> _setCamera(CameraDescription cameraDescription) async {
    CameraController? oldController = state.controller;
    CameraController controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );
    state = state.copyWith(controller: controller, initializeControllerFuture: controller.initialize());
    oldController?.dispose();
  }

  Future<void> startStopRecording(WidgetRef ref) async {
    if (state.isRecording) {
      XFile videoFile = await state.controller!.stopVideoRecording();
      String videoPath = videoFile.path;

      final result = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: true,
      );

      videoPath = result!.path!;
      await uploadVideo(result.path!);
      state = state.copyWith(isRecording: false, videoPath: videoPath);
    } else {
      ref.watch(timerProvider.notifier).state = 10;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (ref.watch(timerProvider.notifier).state > 0) {
          ref.watch(timerProvider.notifier).state -= 1;
        } else {
          timer.cancel();
          state.controller!.stopVideoRecording();
          state = state.copyWith(isRecording: true);
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
    CameraLensDirection currentLensDirection = state.controller!.description.lensDirection;
    CameraLensDirection newLensDirection =
        currentLensDirection == CameraLensDirection.front ? CameraLensDirection.back : CameraLensDirection.front;

    CameraDescription newCamera =
        cameras!.firstWhere((camera) => camera.lensDirection == newLensDirection, orElse: () => cameras!.first);
    _setCamera(newCamera);
  }

  Future<void> uploadVideo(String path) async {
    try {
      FirebaseStorage.instance.ref('video/${basename(path)}').putFile(File(path));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    state.controller?.dispose();
    super.dispose();
  }
}
