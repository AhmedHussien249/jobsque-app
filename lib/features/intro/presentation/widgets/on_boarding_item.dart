import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/features/intro/data/models/on_boarding_model.dart';
import 'package:jobsque/features/intro/presentation/widgets/on_boarding_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.controller,
    required this.data,
  });

  final PageController controller;
  final OnBoardingModel data;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: OnBoardingAppBar(
              onPressed: () {
                controller.jumpToPage(2);
              },
            ),
          ),

          Image.asset(
            data.imageUrl,
            height: screenHeight * .4,
            width: screenWidth,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(data.title, style: AppStyles.medium32),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(data.subTitle, style: AppStyles.regular16),
          ),
          SizedBox(height: 36),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xff3366FF),
                // dotColor: AppColors.red
                dotHeight: 10,
                spacing: 8,
                // dotWidth: 10
              ),
            ),
          ),
          SizedBox(height: 36),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: CustomButton(
              text: data.buttonText,
              onPressed: () async {
                if (data.buttonText == 'Get Started') {
                  final appPrefs = sl<AppPreferences>();
                  GoRouter.of(context).go(AppRouter.kLoginView);

                  await appPrefs.setOnboardingSeen();
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
