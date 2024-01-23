import 'package:baro_project/provider/camera_provider.dart';
import 'package:baro_project/widgets/app_bar_back.dart';
import 'package:baro_project/widgets/classify_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';

import '../provider/timer_provider.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider);
    final timerState = ref.watch(timerProvider);
    final isPause = ref.watch(pauseProvider);

    List<Widget> actionButtons = [
      FloatingActionButton(
        heroTag: "Start and Stop",
        onPressed: () => ref.watch(cameraProvider.notifier).startStopRecording(ref, context),
        child: FaIcon(cameraState.isRecording ? FontAwesomeIcons.stop : FontAwesomeIcons.play),
      ),
      const SizedBox(width: 10.0),
      FloatingActionButton(
        heroTag: "Pause and Resume",
        onPressed: () => ref.watch(cameraProvider.notifier).pauseResumeRecording(ref),
        child: FaIcon(isPause ? FontAwesomeIcons.play : FontAwesomeIcons.pause),
      ),
      const SizedBox(width: 10.0),
    ];

    if (!cameraState.isRecording) {
      actionButtons.add(
        FloatingActionButton(
          heroTag: "Switch Camera",
          onPressed: () => ref.watch(cameraProvider.notifier).switchCamera(),
          child: const FaIcon(FontAwesomeIcons.rotate),
        ),
      );
    }

    return Scaffold(
      appBar: customAppBarBack(context, () => context.pop()),
      body: Stack(
        children: <Widget>[
          cameraState.controller != null && cameraState.controller!.value.isInitialized
              ? Screenshot(controller: ref.watch(screenshotProvider), child: CameraPreview(cameraState.controller!))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          // if (!cameraState.isRecording && timerState.currentTime == 0)
          //   Positioned(
          //     left: MediaQuery.of(context).size.width * 0.1,
          //     right: MediaQuery.of(context).size.width * 0.1,
          //     top: MediaQuery.of(context).size.height * 0.1,
          //     bottom: MediaQuery.of(context).size.height * 0.1,
          //     child: Image.asset(
          //       'assets/images/frame.png',
          //       width: MediaQuery.of(context).size.width * 0.5,
          //       height: MediaQuery.of(context).size.height * 0.5,
          //     ),
          //   ),
          if (timerState.currentTime > 0)
            Center(
              child: Text(
                "${timerState.currentTime}",
                style: const TextStyle(fontSize: 128.0, fontWeight: FontWeight.w700),
              ),
            ),
          const ClassifyToast(), 
          if (cameraState.isCompressing || cameraState.isUploading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actionButtons,
      ),
    );
  }
}
