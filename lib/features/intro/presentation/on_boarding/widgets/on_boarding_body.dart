import 'package:flutter/material.dart';
import 'package:joblink/features/intro/data/models/on_boarding_model.dart';
import 'package:joblink/features/intro/presentation/on_boarding/widgets/on_boarding_item.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: onboardingData.length,
      itemBuilder: (context, index) {
        return OnBoardingItem(
          controller: controller,
          data: onboardingData[index],
        );
      },
    );
  }
}