

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      selectedLabelStyle: AppStyles.medium10,
      unselectedLabelStyle: AppStyles.medium10,
      selectedItemColor: const Color(0xff3366FF),
      unselectedItemColor: const Color(0xff9CA3AF),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          activeIcon: _navIcon(AppAssets.home, true),
          icon: _navIcon(AppAssets.home, false),
          label: "Home",
        ),
        // BottomNavigationBarItem(
        //   activeIcon: _navIcon(AppAssets.message, true),
        //   icon: _navIcon(AppAssets.message, false),
        //   label: "Messages",
        // ),
        BottomNavigationBarItem(
          activeIcon: _navIcon(AppAssets.briefcase, true),
          icon: _navIcon(AppAssets.briefcase, false),
          label: "Applied",
        ),
        BottomNavigationBarItem(
          activeIcon: _navIcon(AppAssets.saved, true),
          icon: _navIcon(AppAssets.saved, false),
          label: "Saved",
        ),
        BottomNavigationBarItem(
          activeIcon: _navIcon(AppAssets.profile, true),
          icon: _navIcon(AppAssets.profile, false),
          label: "Profile",
        ),
      ],
    );
  }

  SvgPicture _navIcon(String asset, bool isActive) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(
        isActive ? const Color(0xff3366FF) : const Color(0xff9CA3AF),
        BlendMode.srcIn,
      ),
    );
  }
}
