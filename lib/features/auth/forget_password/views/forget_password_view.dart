import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/login/widgets/auth_custom_app_bar.dart';

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
            child: ForgetPasswordContet(),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordContet extends StatefulWidget {
  const ForgetPasswordContet({super.key});

  @override
  State<ForgetPasswordContet> createState() => _ForgetPasswordContetState();
}

class _ForgetPasswordContetState extends State<ForgetPasswordContet> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void onLoginPressed() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      log('Email: $email');
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
      child: Column(
        children: [ForgetPasswordFormSection(emailController: emailController),
        Spacer(),
         ForgetPasswordBottomSection()],
      ),
    );
  }
}

class ForgetPasswordFormSection extends StatelessWidget {
  const ForgetPasswordFormSection({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: true),
        SizedBox(height: 39),
        Text(
          AppStrings.resetPassword,
          style: AppStyles.medium28.copyWith(color: const Color(0xff111827)),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.forgetPasswordSubtitle,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
        ),
        SizedBox(height: 40),
        CustomTextFormField(
          controller: emailController,
          hint: 'email',
          prefixIcon: Icon(FontAwesomeIcons.envelope),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class ForgetPasswordBottomSection extends StatelessWidget {
  const ForgetPasswordBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.rememberPassword,
              style: AppStyles.medium14.copyWith(
                color: const Color(0xff9CA3AF),
              ),
            ),
            SizedBox(width: 6,),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.login,
                style: AppStyles.medium14.copyWith(
                  color: const Color(0xff3366FF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: AppStrings.requestPasswordreset,
          onPressed: () {},
        ),
      ],
    );
  }
}
