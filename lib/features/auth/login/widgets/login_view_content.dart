import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:joblink/features/auth/login/widgets/login_bottom_section.dart';
import 'package:joblink/features/auth/login/widgets/login_form_section.dart';

class LoginBodyContent extends StatefulWidget {
  const LoginBodyContent({super.key});

  @override
  State<LoginBodyContent> createState() => _LoginBodyContentState();
}

class _LoginBodyContentState extends State<LoginBodyContent> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isRememberMeChecked = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void onLoginPressed() {
    if (formKey.currentState!.validate()) {
      final email = userNameController.text.trim();
      final password = passwordController.text;
      log('Email: $email, Password: $password');
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // الجزء العلوي من الشاشة
          LoginFormSection(
            userNameController: userNameController,
            passwordController: passwordController,
            isPasswordObscure: isPasswordObscure,
            isRememberMeChecked: isRememberMeChecked,
            togglePasswordVisibility: togglePasswordVisibility,
            onRememberMeChanged: (value) {
                setState(() {
                  isRememberMeChecked = value;
                });
              },
          ),
          // Spacer علشان يفصل الجزء العلوي عن الزرار
          const Spacer(),

          // الجزء السفلي الثابت
          LoginBottomSection(onLoginPressed: onLoginPressed),
        ],
      ),
    );
  }
}

