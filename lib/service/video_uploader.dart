import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class VideoUploader {
  Future<String> uploadVideo(String path) async {
    try {
      await FirebaseStorage.instance.ref('video/${basename(path)}').putFile(File(path), SettableMetadata(contentType: 'video/mp4'));
      String downloadURL = await FirebaseStorage.instance.ref('video/${basename(path)}').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      log(e.toString());
      return '';
    }
  }
}
