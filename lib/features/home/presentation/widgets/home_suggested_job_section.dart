import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class HomeSuggestedJobSection extends StatefulWidget {
  const HomeSuggestedJobSection({super.key});

  @override
  State<HomeSuggestedJobSection> createState() =>
      _HomeSuggestedJobSectionState();
}

class _HomeSuggestedJobSectionState extends State<HomeSuggestedJobSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= 3) _currentPage = 0;

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Suggested Job", style: AppStyles.medium18),
            Text(
              "View all",
              style: AppStyles.medium14.copyWith(
                color: const Color(0xff3366FF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,

          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SuggestedJopItem(),
            ),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class TagSuggestedJop extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const TagSuggestedJop({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tagWidth = (screenWidth - 50 * 2 - 8 * 2) / 3;

    return SizedBox(
      width: tagWidth,
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: AppStyles.regular12.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}

class SuggestedJopItem extends StatelessWidget {
  const SuggestedJopItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff091A7A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(AppAssets.zoomLogo, height: 40, width: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Designer",
                    style: AppStyles.medium18.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Zoom • United States",
                    style: AppStyles.regular12.copyWith(
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                AppAssets.archiveMinus,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            direction: Axis.horizontal,

            children: [
              TagSuggestedJop(
                label: 'Fulltime',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: 'Remote',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: 'Design',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Text(
                  "\$12K-15K/Month",
                  style: AppStyles.medium18.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.3, // 30% من عرض الشاشة
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xff3366FF),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onPressed: () {},
                  child: FittedBox(child: const Text("Apply now")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
