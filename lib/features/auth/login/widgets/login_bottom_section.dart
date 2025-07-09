
import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/features/auth/login/widgets/social_button.dart';


class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({super.key, required this.onLoginPressed});
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.dontHaveAcc,
              style: AppStyles.medium14.copyWith(
                color: const Color(0xff9CA3AF),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                '  Register',
                style: AppStyles.regular14.copyWith(
                  color: const Color(0xff3366FF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: CustomButton(text: 'Login', onPressed: onLoginPressed),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 70.5, height: 1, color: const Color(0xffD1D5DB)),
            const SizedBox(width: 25),
            Text(
              AppStrings.orLoginWith,
              style: AppStyles.regular14.copyWith(
                color: const Color(0xff6B7280),
              ),
            ),
            const SizedBox(width: 25),
            Container(width: 70.5, height: 1, color: const Color(0xffD1D5DB)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              asset: AppAssets.google,
              label: AppStrings.google,
            ),
            const SizedBox(width: 16),
            SocialButton(
              asset: AppAssets.facebook,
              label: AppStrings.facebook,
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}