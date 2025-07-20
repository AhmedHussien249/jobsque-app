import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/service_locator.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    log(screenWidth.toString());
    var logoWidth = screenWidth * 0.4;
    final double circleDiameter = screenWidth;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: circleDiameter * 1,
              height: circleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD6E4FF).withValues(alpha: 0.14),
              ),
            ),
            Container(
              width: circleDiameter * 0.8,
              height: circleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD6E4FF).withValues(alpha: 0.14),
              ),
            ),
            Container(
              width: circleDiameter * 0.5,
              height: circleDiameter * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffD6E4FF).withValues(alpha: 0.3),
              ),
            ),
            Image.asset(AppAssets.logo, width: logoWidth),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    final appPrefs = sl<AppPreferences>();
    final hasSeenIntro = appPrefs.hasSeenOnboarding();
    final isLoggedIn = appPrefs.isLoggedIn();
    final isRemembered = appPrefs.isRemembered();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (isLoggedIn && isRemembered) {
        GoRouter.of(
          context,
        ).go(AppRouter.kHomeView); // ✅ Skip login & onboarding
      } else if (hasSeenIntro) {
        GoRouter.of(context).go(AppRouter.kLoginView);
      } else {
        GoRouter.of(context).go(AppRouter.kOnBoardingView);
      }
    });
  }
}
