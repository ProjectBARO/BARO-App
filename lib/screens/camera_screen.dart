import 'package:baro_project/provider/camera_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraState = ref.watch(cameraProvider);
    final timer = ref.watch(timerProvider);
    final isPause = ref.watch(pauseProvider);

    List<Widget> actionButtons = [
      FloatingActionButton(
        heroTag: "Start and Stop",
        onPressed: () => ref.watch(cameraProvider.notifier).startStopRecording(ref),
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
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: cameraState.initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(cameraState.controller!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // if(!cameraState.isRecording) Positioned(
          //촬영 프레임
          // )
          if (timer > 0)
            Center(
              child: Text(
                "$timer",
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700),
              ),
            ),
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
