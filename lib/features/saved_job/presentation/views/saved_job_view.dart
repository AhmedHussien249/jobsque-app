import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/presentation/widgets/recent_job_item.dart';
import 'package:jobsque/features/saved_job/presentation/view_model/cubits/saved_jobs_cubit.dart';
import 'package:jobsque/features/saved_job/presentation/view_model/cubits/saved_jobs_state.dart';

class SavedJobView extends StatelessWidget {
  const SavedJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(child: Text("Saved", style: AppStyles.medium20)),
        ),

        BlocBuilder<SavedJobsCubit, SavedJobsState>(
          builder: (context, state) {
            if (state is SavedJobsLoaded && state.jobs.isNotEmpty) {
              final count = state.jobs.length;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(color: const Color(0xffE5E7EB)),
                  child: Center(
                    child: Text(
                      "$count ${count == 1 ? "Saved Job" : "Saved Jobs"}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        Expanded(
          child: BlocBuilder<SavedJobsCubit, SavedJobsState>(
            builder: (context, state) {
              if (state is SavedJobsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SavedJobsLoaded) {
                if (state.jobs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.noSavedJob, height: 200),

                        Text(
                          "Nothing has been saved yet",
                          style: AppStyles.medium24,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Press the star icon on the job you want to save.",
                          style: AppStyles.regular16.copyWith(
                            color: Color(0xff6B7280),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.jobs.length,
                  itemBuilder: (context, index) {
                    final job = state.jobs[index];
                    return RecentJobItem(
                      job: job,
                      companyName: job.compName,
                      jobTitle: job.name,
                      location: job.location,
                      image: job.image,
                      salary: job.salary,
                    );
                  },
                );
              } else if (state is SavedJobsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
