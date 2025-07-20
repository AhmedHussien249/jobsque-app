import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/presentation/widgets/auth_custom_app_bar.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.isPasswordObscure,
    required this.isRememberMeChecked,
    required this.togglePasswordVisibility,
    required this.onRememberMeChanged,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final bool isPasswordObscure;
  final bool isRememberMeChecked;
  final VoidCallback togglePasswordVisibility;
  final ValueChanged<bool> onRememberMeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: false),
        const SizedBox(height: 44),
        Text(AppStrings.login, style: AppStyles.medium28),
        const SizedBox(height: 8),
        Text(AppStrings.orSignUpWith, style: AppStyles.regular14),
        const SizedBox(height: 8),
        Text(AppStrings.loginSubtitle, style: AppStyles.regular16),
        const SizedBox(height: 44),
        CustomTextFormField(
          controller: userNameController,
          hint: 'email',
          prefixIcon: const Icon(
            Icons.person_2_outlined,
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
            if (value == null || value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isRememberMeChecked,
                  onChanged: (value) {
                    onRememberMeChanged(value ?? false);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  activeColor: const Color(0xff3366FF),
                ),
                Text('Remember Me', style: AppStyles.regular14),
              ],
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kForgetPasswordView);
              },
              child: Text(
                'Forgot Password?',
                style: AppStyles.regular14.copyWith(
                  color: const Color(0xff3366FF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
