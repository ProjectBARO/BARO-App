import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class ClassifyNotifier extends StateNotifier<bool> {
  Interpreter? _interpreter;

  static const String MODEL_FILE_NAME = "CNN_model.tflite";
  static const int INPUT_SIZE = 28;
  static const double THRESHOLD = 0.5;
  // ImageProcessor? imageProcessor;
  // int? padSize;

  ClassifyNotifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) : super(true) {
    loadModel(interpreter: interpreter);
  }

  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter =
          interpreter ?? await Interpreter.fromAsset(MODEL_FILE_NAME, options: InterpreterOptions()..threads = 4);
    } catch (e) {
      log(e.toString());
    }
  }

  // TensorImage getProcessedImage(TensorImage? inputImage) {
  //   padSize = math.max(inputImage?.height ?? 0, inputImage?.width ?? 0);

  //   imageProcessor ??= ImageProcessorBuilder()
  //       .add(ResizeWithCropOrPadOp(padSize ?? 0, padSize ?? 0))
  //       .add(ResizeOp(INPUT_SIZE, INPUT_SIZE, ResizeMethod.NEAREST_NEIGHBOUR))
  //       .add(NormalizeOp(0, 1))
  //       .build();
  //   inputImage = imageProcessor?.process(inputImage!);
  //   return inputImage!;
  // }

  void predict(Float32List imgData) {
    if (_interpreter == null) return;

    List<Object> inputs = [
      imgData.reshape([1, INPUT_SIZE, INPUT_SIZE, 3])
    ];
    TensorBuffer output0 =
        TensorBuffer.createFixedSize(_interpreter!.getOutputTensor(0).shape, _interpreter!.getOutputTensor(0).type);
    Map<int, Object> outputs = {0: output0.buffer};
    _interpreter?.runForMultipleInputs(inputs, outputs);

    Float32List resultArray = output0.buffer.asFloat32List();
    print(resultArray);
    state = resultArray[0] > THRESHOLD ? false : true;
  }

  Interpreter? get interpreter => _interpreter;
}

final classifyProvider = StateNotifierProvider.autoDispose<ClassifyNotifier, bool?>((ref) => ClassifyNotifier());
