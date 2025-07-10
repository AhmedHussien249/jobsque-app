import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/features/auth/presentation/widgets/create_new_password_bottom.dart';
import 'package:jobsque/features/auth/presentation/widgets/create_new_password_form.dart';

class CreateNewPasswordContent extends StatefulWidget {
  const CreateNewPasswordContent({super.key});

  @override
  State<CreateNewPasswordContent> createState() =>
      _CreateNewPasswordContentState();
}

class _CreateNewPasswordContentState extends State<CreateNewPasswordContent> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void onResetPressed() {
    if (formKey.currentState!.validate()) {
      final password = passwordController.text.trim();
      final password2 = passwordController2.text.trim();
      log('password: $password, password2: $password2');
      GoRouter.of(context).pushReplacement(AppRouter.kPasswordChangedView);
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CreateNewPasswordForm(
            passwordController: passwordController,
            passwordController2: passwordController2,
            isPasswordObscure: isPasswordObscure,
            isRememberMeChecked: false,
            togglePasswordVisibility: togglePasswordVisibility,
          ),
          Spacer(),
          CreateNewPasswordBottom(onLoginPressed: onResetPressed),
        ],
      ),
    );
  }
}
