import 'dart:isolate';
import 'dart:typed_data';
import 'package:image/image.dart' as imagelib;

class ImageConverter {
  static const int INPUT_SIZE = 28;

  static Future<Float32List> convertImageInIsolate(Uint8List img) async {
    final port = ReceivePort();
    await Isolate.spawn(_imageConversionIsolate, [port.sendPort, img]);
    return await port.first as Float32List;
  }

  static void _imageConversionIsolate(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final Uint8List img = args[1];

    imagelib.Image? image = imagelib.decodeImage(img);
    if (image == null) {
      sendPort.send(Float32List(0));
      return;
    }

    imagelib.Image resizedImage = imagelib.copyResize(image, width: INPUT_SIZE, height: INPUT_SIZE);
    final imgData = Float32List(INPUT_SIZE * INPUT_SIZE * 3);
    int index = 0;

    for (int y = 0; y < INPUT_SIZE; y++) {
      for (int x = 0; x < INPUT_SIZE; x++) {
        final pixel = resizedImage.getPixel(x, y);
        imgData[index++] = pixel.r / 255.0;
        imgData[index++] = pixel.g / 255.0;
        imgData[index++] = pixel.b / 255.0;
      }
    }

    sendPort.send(imgData);
  }
}
