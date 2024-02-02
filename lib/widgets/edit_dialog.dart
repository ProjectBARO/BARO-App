import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../provider/auth_provider.dart';
import '../provider/user_provider.dart';
import 'info_widget.dart';

class EditDialog extends StatefulWidget {
  final WidgetRef ref;
  final String title;
  final String value;
  final User user;

  const EditDialog(this.ref, this.title, this.value, this.user, {super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController controller;
  String gender = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    gender = getGender(widget.user.gender);
  }

  @override
  Widget build(BuildContext context) {
    final authService = widget.ref.read(authProvider);

    return AlertDialog(
      title: Text("${widget.title} 수정"),
      content: widget.title == "출생연도"
          ? TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: widget.title,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            )
          : widget.title == "성별"
              ? DropdownButton<String>(
                  value: gender,
                  items: <String>['남성', '여성', '공개 안함'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: widget.title,
                  ),
                ),
      actions: [
        TextButton(
          child: const Text("확인"),
          onPressed: () async {
            User updatedUser =
                widget.title == "성별" ? widget.user.copyWith(gender: getGenderToUpdate(gender)) : getUpdatedUser(widget.title, widget.user, controller);
            await authService.updateUserInfo(updatedUser).then((value) {
              widget.ref.read(userProvider.notifier).setUser(updatedUser);
              Navigator.of(context).pop();
            });
          },
        ),
        TextButton(
          child: const Text("취소"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

