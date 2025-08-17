import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/service_locator.dart';

import 'package:jobsque/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:jobsque/features/home/presentation/widgets/home_body.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_cubit.dart';
import 'package:jobsque/features/show_apply_job/presentation/views/show_applied_job_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  // الصفحات المرتبطة بكل عنصر في الـ bottom nav
  final List<Widget> pages = [
    const HomeBody(),
    const MessagesPage(),
    BlocProvider(create: (context) =>  sl<ShowAppliedJobCubit>(), child: const AppliedJobsView()),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( child: currentIndex == 2 // AppliedJobsView
      ? pages[currentIndex] // سيبه Scaffold طبيعي من غير scroll
      : SingleChildScrollView(child: pages[currentIndex]),
),
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

// class AppliedPage extends StatelessWidget {
//   const AppliedPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Center(child: Text('Applied Page'));
// }

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
