import 'package:baro_project/provider/camera_provider.dart';
import 'package:baro_project/widgets/app_bar_back.dart';
import 'package:baro_project/widgets/classify_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../provider/timer_provider.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider);
    final timerState = ref.watch(timerProvider);
    final isPause = ref.watch(pauseProvider);

    List<Widget> actionButtons = [
      FloatingActionButton(
        heroTag: "Start and Stop",
        onPressed: () => ref.watch(cameraProvider.notifier).startStopRecording(ref, context),
        shape: const CircleBorder(),
        child: FaIcon(cameraState.isRecording ? FontAwesomeIcons.stop : FontAwesomeIcons.play),
      ),
      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
    ];

    if (cameraState.isRecording) {
      actionButtons.add(
        FloatingActionButton(
          heroTag: "Pause and Resume",
          onPressed: () => ref.watch(cameraProvider.notifier).pauseResumeRecording(ref),
          shape: const CircleBorder(),
          child: FaIcon(isPause ? FontAwesomeIcons.play : FontAwesomeIcons.pause),
        ),
      );
    }

    if (!cameraState.isRecording) {
      actionButtons.add(
        FloatingActionButton(
          heroTag: "Switch Camera",
          onPressed: () => ref.watch(cameraProvider.notifier).switchCamera(),
          shape: const CircleBorder(),
          child: const FaIcon(FontAwesomeIcons.rotate),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: customAppBarBack(context, () => context.pop()),
        body: Stack(
          children: <Widget>[
            cameraState.controller != null && cameraState.controller!.value.isInitialized
                ? Screenshot(
                    controller: ref.watch(screenshotProvider),
                    child: CameraPreview(cameraState.controller!, key: ValueKey(cameraState.controller)))
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
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
        floatingActionButton: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actionButtons,
            )
          ]
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
