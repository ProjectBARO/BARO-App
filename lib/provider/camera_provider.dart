import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import '../models/camera.dart';
import 'timer_provider.dart';

final cameraProvider = StateNotifierProvider<CameraNotifier, CameraState>((ref) => CameraNotifier());
final pauseProvider = StateProvider<bool>((ref) => false);

class CameraNotifier extends StateNotifier<CameraState> with WidgetsBindingObserver {
  CameraNotifier() : super(CameraState()) {
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
      final result = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: true,
      );
      videoPath = result!.path!;
      state = state.copyWith(isCompressing: false, isUploading: true);
      await uploadVideo(result.path!);
      state = state.copyWith(isRecording: false, videoPath: videoPath, isUploading: false);
    } else {
      timer.startTimer();
      await Future.delayed(const Duration(seconds: 10));
      // if(timer.state.currentTime == 0) {
      await state.controller!.startVideoRecording();
      state = state.copyWith(isRecording: true);
      // }
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

  Future<void> uploadVideo(String path) async {
    try {
      await FirebaseStorage.instance.ref('video/${basename(path)}').putFile(File(path));
    } on FirebaseException catch (e) {
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
