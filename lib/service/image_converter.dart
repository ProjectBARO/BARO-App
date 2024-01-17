import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

const shift = (0xFF << 24);

class ImageConverter {
  static imglib.Image? convertJpegToImage(Uint8List img) {
    imglib.Image? convertedImage = imglib.decodeImage(img);
    return convertedImage;
  }

  static Future<Uint8List?> convertXFileToJpeg(XFile file) async {
    final byteData = await file.readAsBytes();
    imglib.Image? image = imglib.decodeImage(byteData);
    Uint8List jpeg = imglib.encodeJpg(image!);
    return jpeg;
  }
}
