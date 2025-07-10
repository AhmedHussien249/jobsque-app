import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';

class ForgetPasswordBottomSection extends StatelessWidget {
  const ForgetPasswordBottomSection({super.key, required this.onLoginPressed});
  final VoidCallback onLoginPressed;

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
            SizedBox(width: 6),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
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
          onPressed: onLoginPressed,
        ),
      ],
    );
  }
}
