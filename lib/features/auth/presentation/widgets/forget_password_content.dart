import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/features/auth/presentation/widgets/forget_password_bottom_section.dart';
import 'package:jobsque/features/auth/presentation/widgets/forget_password_form_section.dart';

class ForgetPasswordContent extends StatefulWidget {
  const ForgetPasswordContent({super.key});

  @override
  State<ForgetPasswordContent> createState() => _ForgetPasswordContentState();
}

class _ForgetPasswordContentState extends State<ForgetPasswordContent> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void onRequestPasswordPressed() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      log('Email: $email');
      GoRouter.of(context).pushReplacement(AppRouter.kCheckYourEmailView);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ForgetPasswordFormSection(emailController: emailController),
          Spacer(),
          ForgetPasswordBottomSection(onLoginPressed: onRequestPasswordPressed),
        ],
      ),
    );
  }
}
