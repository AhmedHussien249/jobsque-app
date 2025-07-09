
import 'package:jobsque/core/utils/app_assets.dart';

class OnBoardingModel {
  final String title;
  final String subTitle;
  final String imageUrl;
  final String buttonText;

  const OnBoardingModel( {
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.buttonText,
  });
}

final List<OnBoardingModel> onboardingData = [
  OnBoardingModel(
    
    title: 'Find a job, and start building your career from now on',
    subTitle:
        'Explore over 25,924 available job roles and upgrade your operator now.',
    imageUrl: AppAssets.onBoarding1,
    buttonText: 'next',
    
  ),
  OnBoardingModel(
    title: 'Hundreds of jobs are waiting for you to join together',
    subTitle:
        'Immediately join us and start applying for the job you are interested in.',
    imageUrl: AppAssets.onBoarding2,
    buttonText: 'next',
  ),
  OnBoardingModel(
    title: 'Get the best choice for the job you have always dreamed of',
    subTitle:
        'Immediately join us and start applying for the job you are interested in.',
    imageUrl: AppAssets.onBoarding3,
    buttonText: 'Get Started',
  ),
];
