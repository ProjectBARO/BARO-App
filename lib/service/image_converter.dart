import 'dart:typed_data';
import 'package:image/image.dart' as imagelib;

class ImageConverter {
  static const int INPUT_SIZE = 28;
  static Float32List convertImage(Uint8List img) {
    imagelib.Image? image = imagelib.decodeImage(img);
    imagelib.Image resizedImage = imagelib.copyResize(image!, width: INPUT_SIZE, height: INPUT_SIZE);

    var imgData = Float32List(INPUT_SIZE * INPUT_SIZE * 3);
    int index = 0;

    for (var x = 0; x < INPUT_SIZE; x++) {
      for (var y = 0; y < INPUT_SIZE; y++) {
        var pixel = resizedImage.getPixel(x, y);
        imgData[index++] = pixel.r / 255.0; // Red
        imgData[index++] = pixel.g / 255.0; // Green
        imgData[index++] = pixel.b / 255.0; // Blue
      }
    }
    return imgData;
  }
}
