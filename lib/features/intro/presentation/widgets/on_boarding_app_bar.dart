import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class OnBoardingAppBar extends StatelessWidget {
  const OnBoardingAppBar({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(AppAssets.logo, height: 19, width: 81),
          TextButton(
            onPressed: onPressed,
            child: Text('Skip', style: AppStyles.regular16),
          ),
        ],
      ),
    );
  }
}
