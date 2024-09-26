import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class VideoUploader {
  Future<String> uploadVideo(String path, ValueNotifier<double> progressNotifier) async {
    try {
      // await FirebaseStorage.instance.ref('video/${basename(path)}').putFile(File(path), SettableMetadata(contentType: 'video/mp4'));
      // String downloadURL = await FirebaseStorage.instance.ref('video/${basename(path)}').getDownloadURL();
      // return downloadURL;
      final ref = FirebaseStorage.instance.ref('video/${basename(path)}');
      final uploadTask = ref.putFile(File(path), SettableMetadata(contentType: 'video/mp4'));

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        progressNotifier.value = progress;
      });

      await uploadTask;
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      log(e.toString());
      return '';
    }
  }
}
