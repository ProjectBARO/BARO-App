import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import '../models/classifier.dart';

class ClassifierNotifier extends StateNotifier<Classifier> {
  Interpreter? _interpreter;

  static const String MODEL_FILE_NAME = "baro_model.tflite";
  static const int INPUT_SIZE = 28;

  ClassifierNotifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) : super(Classifier()) {
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
    bool turtleState = resultArray[0] > resultArray[1] ? true : false;
    state = state.copyWith(isTurtle: turtleState);
    log("${resultArray[0]} ${resultArray[1]}");
    _increment();
  }

  void _increment() {
    if (state.isTurtle) {
      state.alertCount++;
    }
  }

  Interpreter? get interpreter => _interpreter;
}

final classifierProvider =
    StateNotifierProvider.autoDispose<ClassifierNotifier, Classifier>((ref) => ClassifierNotifier());
