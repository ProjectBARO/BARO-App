import 'package:baro_project/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';

Widget buildInfoList(String title, String value, BuildContext context, WidgetRef ref, {bool canEdit = false}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w300)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            if (canEdit)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.05,
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: FaIcon(FontAwesomeIcons.pen, size: MediaQuery.of(context).size.width * 0.04),
                  onPressed: () {
                    final user = ref.read(userProvider.notifier).currentUser;
                    showDialog(
                      context: context,
                      builder: (context) => EditDialog(ref, title, value, user!)
                    );
                  },
                ),
              )
          ],
        )
      ],
    ),
  );
}

User getUpdatedUser(String title, User user, TextEditingController controller) {
  switch (title) {
    case "닉네임":
      return user.copyWith(nickname: controller.text);
    case "출생 연도":
      return user.copyWith(birthday: int.parse(controller.text));
    case "성별":
      return user.copyWith(gender: controller.text);
    default:
      throw Exception('Unknown field');
  }
}

String getGender(String? gender) {
  switch (gender) {
    case 'male':
      return '남성';
    case 'female':
      return '여성';
    case '':
      return '공개 안함';
    default:
      return '공개 안함';
  }
}

String getGenderToUpdate(String? gender) {
  switch (gender) {
    case '남성':
      return 'male';
    case '여성':
      return 'female';
    case '공개 안함':
      return '';
    default:
      return '';
  }
}
