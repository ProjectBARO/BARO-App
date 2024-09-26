import 'dart:developer';
import 'dart:io';
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
      final interpreterOptions = InterpreterOptions();

      if (Platform.isAndroid) {
        interpreterOptions.addDelegate(XNNPackDelegate());
      }

      if (Platform.isIOS) {
        interpreterOptions.addDelegate(GpuDelegateV2());
      }

      _interpreter = interpreter ?? await Interpreter.fromAsset(MODEL_FILE_NAME, options: interpreterOptions);
    } catch (e) {
      log("모델 로드 오류 : $e");
    }
  }

  Future<void> predict(Future<Float32List> imgDataFuture) async {
    if (_interpreter == null) return;

    try {
      Float32List imgData = await imgDataFuture;

      await Future.microtask(() {
        List<Object> inputs = [imgData.reshape([1, INPUT_SIZE, INPUT_SIZE, 3])];
        TensorBuffer output0 = TensorBuffer.createFixedSize(_interpreter!.getOutputTensor(0).shape, _interpreter!.getOutputTensor(0).type);
        Map<int, Object> outputs = {0: output0.buffer};
        _interpreter?.runForMultipleInputs(inputs, outputs);
        Float32List resultArray = output0.buffer.asFloat32List();

        bool turtleState = resultArray[0] > resultArray[1] ? true : false;
        if (turtleState != state.isTurtle) {
          state = state.copyWith(isTurtle: turtleState);
        }

        log("${resultArray[0]} ${resultArray[1]}");
        _increment();
      });
    }
    catch (e) {
      log("이미지 추론 오류 : $e");
    }
  }

  void _increment() {
    if (state.isTurtle) {
      state.alertCount++;
    }
  }
}

final classifierProvider = StateNotifierProvider.autoDispose<ClassifierNotifier, Classifier>((ref) => ClassifierNotifier());
