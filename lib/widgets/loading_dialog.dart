import 'package:flutter/material.dart';

Dialog loadingDialog() {
  return const Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: CircularProgressIndicator(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text("잠시만 기다려주세요...", style: TextStyle(fontSize: 20.0)),
        )      
      ],
    ),
  );
}