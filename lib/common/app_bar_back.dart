import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PreferredSizeWidget customAppBarBack(BuildContext context, VoidCallback onPressed) {
  return AppBar(
    leading: IconButton(
      icon: const FaIcon(FontAwesomeIcons.angleLeft),
      onPressed: onPressed,
    ),
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0.0,
  );
}
