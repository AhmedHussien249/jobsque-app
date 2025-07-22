import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/presentation/widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  // الصفحات المرتبطة بكل عنصر في الـ bottom nav
  final List<Widget> pages = const [
    HomeBody(),
    MessagesPage(),
    AppliedPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(child: pages[currentIndex])),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

// Dummy Pages (ممكن تبدلهم بالـ widgets الحقيقية بتاعتك)
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Messages Page'));
}

class AppliedPage extends StatelessWidget {
  const AppliedPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Applied Page'));
}

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Saved Page'));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Profile Page'));
}

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
        BottomNavigationBarItem(
          activeIcon: _navIcon(AppAssets.message, true),
          icon: _navIcon(AppAssets.message, false),
          label: "Messages",
        ),
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
