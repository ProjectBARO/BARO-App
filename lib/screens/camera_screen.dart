import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePhotoPage extends StatefulWidget {
  TakePhotoPage({Key? key}) : super(key: key);

  @override
  TakePhotoPageState createState() => TakePhotoPageState();
}

class TakePhotoPageState extends State<TakePhotoPage> {
  bool _cameraInitialized = false;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    readyToCamera();
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  void readyToCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print("not found any cameras");
      return;
    }

    CameraDescription frontCamera = cameras[0];
    for (var camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.max,
    );
    _cameraController.initialize().then(
      (value) {
        setState(() => _cameraInitialized = true);
      },
    );
  }

  void _takePicture() async {
    try {
      final image = await _cameraController.takePicture();
      print('Picture saved at ${image.path}');
    } catch (e) {
      print(e);
    }
  }

  Widget _mainPage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 10 / 18, // _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameraInitialized
          ? _mainPage()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
