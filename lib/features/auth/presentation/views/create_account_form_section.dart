
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/presentation/widgets/auth_custom_app_bar.dart';

class CreateAccountFormSection extends StatelessWidget {
  const CreateAccountFormSection({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.isPasswordObscure,
    required this.togglePasswordVisibility,
    required this.emailController,
  });
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordObscure;
  final VoidCallback togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: true),
        const SizedBox(height: 44),
        Text(AppStrings.createAccount, style: AppStyles.medium28),
        const SizedBox(height: 8),
        Text(AppStrings.createAccountSubtitle, style: AppStyles.regular14),
        const SizedBox(height: 44),
        CustomTextFormField(
          controller: userNameController,
          hint: AppStrings.userName,
          prefixIcon: const Icon(
            Icons.person_2_outlined,
            color: Color(0xff292D32),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your user name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: emailController,
          hint: 'email',
          prefixIcon: const Icon(
            FontAwesomeIcons.envelope,
            color: Color(0xff292D32),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 12),
        Text(
          AppStrings.passMustBe,
          style: AppStyles.regular14.copyWith(color: const Color(0xff6B7280)),
        ),
      ],
    );
  }
}