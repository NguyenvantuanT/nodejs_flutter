import 'package:flutter/material.dart';
import 'package:fontend/featch/components/my_textformfield.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    super.key,
    this.userController,
    this.ageController,
    required this.title,
    this.onPressed, this.action,
  });

  final TextEditingController? userController;
  final TextEditingController? ageController;
  final String title;
  final Function()? onPressed;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFormField(
            controller: userController,
            labelText: 'Tên user',
          ),
          MyTextFormField(
            controller: ageController,
            labelText: 'Tuổi',
          ),
        ],
      ),
      actions: action,
    );
  }
}
