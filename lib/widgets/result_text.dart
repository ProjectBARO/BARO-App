import 'package:flutter/material.dart';

TextSpan buildTextSpan(String text, {double fontSize = 30.0, FontWeight? fontWeight, Color? color}) {
  return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
    )
  );
}
