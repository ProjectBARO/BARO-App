import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class VideoUploader {
  Future<void> uploadVideo(String path) async {
    try {
      await FirebaseStorage.instance.ref('video/${basename(path)}').putFile(File(path));
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
