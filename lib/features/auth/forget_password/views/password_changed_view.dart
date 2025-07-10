import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: PasswordChangedContent(),
        ),
      ),
    );
  }
}
class PasswordChangedContent extends StatelessWidget {
  const PasswordChangedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Spacer(),
        Center(
          child: Image.asset(AppAssets.openEmail, width: 173, height: 142),
        ),
        SizedBox(height: 24),
        Text(AppStrings.checkYourEmail, style: AppStyles.medium24),
        SizedBox(height: 12),
        Text(
          AppStrings.sentAReset,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        CustomButton(text: 'Open email app', onPressed: () {
          GoRouter.of(context).push( AppRouter.kCreateNewPasswordView);
        }),
      ],
    );
  }
}