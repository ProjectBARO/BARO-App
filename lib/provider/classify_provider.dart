import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as imagelib;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ClassifyNotifier extends StateNotifier<int?> {
  Interpreter? _interpreter;

  static const String MODEL_FILE_NAME = "CNN_model.tflite";
  static const int INPUT_SIZE = 28;
  static const double THRESHOLD = 0.5;
  ImageProcessor? imageProcessor;
  int? padSize;
  List<List<int>>? _outputShapes;
  List<TfLiteType>? _outputTypes;

  ClassifyNotifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) : super(null) {
    loadModel(interpreter: interpreter);
  }

  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter =
          interpreter ?? await Interpreter.fromAsset(MODEL_FILE_NAME, options: InterpreterOptions()..threads = 4);
      var outputTensors = _interpreter?.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors?.forEach((tensor) {
        _outputShapes?.add(tensor.shape);
        _outputTypes?.add(tensor.type);
      });
    } catch (e) {
      print(e);
    }
  }

  TensorImage getProcessedImage(TensorImage? inputImage) {
    padSize = max(inputImage?.height ?? 0, inputImage?.width ?? 0);

    imageProcessor ??= ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(padSize ?? 0, padSize ?? 0))
        .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.NEAREST_NEIGHBOUR))
        .add(NormalizeOp(0, 255))
        .build();
    inputImage = imageProcessor?.process(inputImage!);
    return inputImage!;
  }

  void predict(imagelib.Image? image) {
    if (_interpreter == null) return;

    TensorImage inputImage = TensorImage.fromImage(image!);
    inputImage = getProcessedImage(inputImage);

    TensorBuffer outputBuffer = TensorBufferFloat(_outputShapes![0]);

    List<Object> inputs = [inputImage.buffer];
    Map<int, Object> outputs = {0: outputBuffer.buffer};

    _interpreter?.runForMultipleInputs(inputs, outputs);

    Float32List resultArray = outputBuffer.buffer.asFloat32List();
    state = (resultArray[0] > THRESHOLD) ? 1 : 0;
  }

  Interpreter? get interpreter => _interpreter;
}
