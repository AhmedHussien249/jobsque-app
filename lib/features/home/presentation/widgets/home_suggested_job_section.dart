import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/suggested_job_cubit.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/suggested_job_state.dart';
import 'package:jobsque/features/home/presentation/widgets/suggested_job_item.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class HomeSuggestedJobSection extends StatefulWidget {
  const HomeSuggestedJobSection({super.key});

  @override
  State<HomeSuggestedJobSection> createState() => _HomeSuggestedJobSectionState();
}

class _HomeSuggestedJobSectionState extends State<HomeSuggestedJobSection> {
  final PageController pageController = PageController();
  int currentPage = 0;
  Timer? timer;
  
  @override
  void initState() {
    super.initState();
    startAutoScroll();
   
  }

  void startAutoScroll() {
    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (pageController.hasClients) {
        currentPage++;
        if (currentPage >= 3) currentPage = 0;

        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }
    @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
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
              style: AppStyles.medium14.copyWith(color: Color(0xff3366FF)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,
          child: BlocBuilder<JobsCubit, JobsState>(
            builder: (context, state) {
              if (state is JobsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is JobsSuccess) {
                return PageView.builder(
                  itemCount: state.jobs.length,
                  controller: pageController,
            padEnds: false,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SuggestedJopItem(job: state.jobs[index],),
            ),
                );
              } else if (state is JobsFailure) {
                return Center(child: Text("Error: ${state.error}"));
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
