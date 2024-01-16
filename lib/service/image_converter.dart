import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

const shift = (0xFF << 24);

class ImageConverter {
  static imglib.Image? convertImage(CameraImage img) {
    if (img.format.group == ImageFormatGroup.yuv420) {
      return _convertYUV(img);
    } else if (img.format.group == ImageFormatGroup.bgra8888) {
      return _convertBGRA(img);
    } else {
      return null;
    }
  }

  static imglib.Image? _convertBGRA(CameraImage img) {
    imglib.Image convertedImage = imglib.Image.fromBytes(
      width: img.planes[0].width ?? 0,
      height: img.planes[0].height ?? 0,
      bytes: img.planes[0].bytes.buffer,
      format: imglib.Format.uint8,
    );
    return convertedImage;
  }

  static imglib.Image? _convertYUV(CameraImage img) {
    final int width = img.width;
    final int height = img.height;
    final int uvRowStride = img.planes[1].bytesPerRow;
    final int uvPixelStride = img.planes[1].bytesPerPixel ?? 0;
    final convertedImage = imglib.Image(width: width, height: height);

    for (int w = 0; w < width; w++) {
      for (int h = 0; h < height; h++) {
        final int uvIndex = uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final int index = h * width + w;
        final y = img.planes[0].bytes[index];
        final u = img.planes[1].bytes[uvIndex];
        final v = img.planes[2].bytes[uvIndex];

        int r = (y + v * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round().clamp(0, 255);
        int b = (y + u * 1814 / 1024 - 227).round().clamp(0, 255);

        if (convertedImage.isBoundsSafe(height - h, w)) {
          convertedImage.setPixelRgba(w, height - h, r, g, b, shift);
        }
      }
    }
    return convertedImage;
  }
}
