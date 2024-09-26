import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.bullhorn, size: 20.0),
          title: const Text("공지사항"),
          onTap: () {},
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.circleQuestion, size: 20.0),
          title: const Text("자주 묻는 질문"),
          onTap: () {},
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.gear, size: 20.0),
          title: const Text("환경설정"),
          onTap: () {},
        ),
      ],
    ),
  );
}
