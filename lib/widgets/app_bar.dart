import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PreferredSizeWidget customAppBar(BuildContext context) {
  return AppBar(
    leading: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0.0,
    actions: <Widget>[
      IconButton(
        icon: const FaIcon(FontAwesomeIcons.bell),
        onPressed: () {},
      ),
      Builder(
        builder: (context) => IconButton(
          icon: const FaIcon(FontAwesomeIcons.bars),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ),
    ],
  );
}
