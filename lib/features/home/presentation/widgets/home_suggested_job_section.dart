import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/presentation/widgets/suggested_job_item.dart';

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

