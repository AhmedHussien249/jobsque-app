import 'package:flutter/material.dart';
import 'package:jobsque/core/widgets/custom_button.dart';

class CreateNewPasswordBottom extends StatelessWidget {
  const CreateNewPasswordBottom({super.key, required this.onLoginPressed});
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 74),
      child: CustomButton(text: 'Reset password', onPressed: onLoginPressed),
    );
  }
}