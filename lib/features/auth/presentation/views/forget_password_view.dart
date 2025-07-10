import 'package:flutter/material.dart';
import 'package:jobsque/features/auth/presentation/widgets/forget_password_content.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ForgetPasswordContent(),
          ),
        ),
      ),
    );
  }
}
