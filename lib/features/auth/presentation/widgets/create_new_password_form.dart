

import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/presentation/widgets/auth_custom_app_bar.dart';

class CreateNewPasswordForm extends StatelessWidget {
  const CreateNewPasswordForm({
    super.key,
    required this.passwordController,
    required this.isPasswordObscure,
    required this.isRememberMeChecked,
    required this.togglePasswordVisibility, required this.passwordController2,
    
  });
  final TextEditingController passwordController;
  final TextEditingController passwordController2;
  final bool isPasswordObscure;
  final bool isRememberMeChecked;
  final VoidCallback togglePasswordVisibility;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: true),
        SizedBox(height: 44),
        Text(AppStrings.createNewPass, style: AppStyles.medium28),
        SizedBox(height: 8),
        Text(
          AppStrings.setYourNewPass,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
        ),
        SizedBox(height: 44),
        CustomTextFormField(
          controller: passwordController,
          hint: 'Password',
          isPassword: true,
          obscureText: isPasswordObscure,
          onSuffixTap: togglePasswordVisibility,
          prefixIcon: const Icon(Icons.lock_outline),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
        SizedBox(height: 12),
        Text(
          AppStrings.passMustBe,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
        ),
        SizedBox(height: 24),
        CustomTextFormField(
          controller: passwordController2,
          hint: 'Password',
          isPassword: true,
          obscureText: isPasswordObscure,
          onSuffixTap: togglePasswordVisibility,
          prefixIcon: const Icon(Icons.lock_outline),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
        SizedBox(height: 12),
        Text(
          AppStrings.bothPassMustMatch,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
        ),
      ],
    );
  }
}