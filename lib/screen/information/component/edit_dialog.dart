import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../model/user.dart' as user_model;
import '../../login/provider/auth_provider.dart';
import '../../login/provider/user_provider.dart';
import 'info_widget.dart';

class EditDialog extends StatefulWidget {
  final WidgetRef ref;
  final String title;
  final String value;
  final user_model.User user;

  const EditDialog(this.ref, this.title, this.value, this.user, {super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController controller;
  String gender = '';
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    gender = getGender(widget.user.gender);
    if (widget.title == "나이") {
      selectedValue = int.parse(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = widget.ref.read(authProvider);

    return AlertDialog(
      title: Text("${widget.title} 수정"),
      content: widget.title == "나이"
          ? NumberPicker(
              value: selectedValue,
              minValue: 1,
              maxValue: 100,
              onChanged: (newValue) => setState(() {
                selectedValue = newValue;
                controller.text = newValue.toString();
              }),
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
            user_model.User updatedUser = widget.title == "성별"
                ? widget.user.copyWith(gender: getGenderToUpdate(gender))
                : getUpdatedUser(widget.title, widget.user, controller);
            await authService.updateUserInfo(updatedUser).then((value) {
              widget.ref.read(userProvider.notifier).setUser(updatedUser);
              context.pop();
            });
          },
        ),
        TextButton(
          child: const Text("취소"),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
