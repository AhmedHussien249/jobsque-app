import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';

class YourAccountHasBeenSetUp extends StatelessWidget {
  const YourAccountHasBeenSetUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0XFF292D32)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: CheckYourEmailContent(),
        ),
      ),
    );
  }
}

class CheckYourEmailContent extends StatelessWidget {
  const CheckYourEmailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Spacer(),
        Center(child: Image.asset(AppAssets.person, width: 173, height: 142)),
        SizedBox(height: 24),
        Text('Your account has been set up!', style: AppStyles.medium24),
        SizedBox(height: 12),
        Text(
          'We have customized feeds according to your preferences',
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        CustomButton(
          text: 'Get started',
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kLoginView);
          },
        ),
      ],
    );
  }
}
