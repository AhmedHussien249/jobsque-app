import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_bio_data.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_cubit.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_state.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_cubit.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_state.dart';
import 'package:jobsque/features/show_apply_job/presentation/widgets/job_card.dart';
import 'package:jobsque/features/show_apply_job/presentation/widgets/tab_selector.dart';

class AppliedJobsView extends StatefulWidget {
  const AppliedJobsView({super.key});

  @override
  State<AppliedJobsView> createState() => _AppliedJobsViewState();
}

class _AppliedJobsViewState extends State<AppliedJobsView> {
  late ShowAppliedJobCubit cubit;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ShowAppliedJobCubit>();
    cubit.getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Applied Job",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          TabSelector(
            selectedTab: selectedTab,
            onTabSelected: (index) => setState(() => selectedTab = index),
          ),
          Expanded(
            child: BlocBuilder<ShowAppliedJobCubit, ShowAppliedJobState>(
              builder: (context, state) {
                if (state is ShowAppliedJobLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowAppliedJobFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is ShowAppliedJobSuccess) {
                  final jobs = state.jobs.where((job) {
                    if (selectedTab == 0) {
                      return job.reviewed == 0 || job.accept == true;
                    } else {
                      return job.reviewed == 1 && job.accept == false;
                    }
                  }).toList();

                  if (jobs.isEmpty) {
                    return const Center(child: Text('No jobs here'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final appliedJob = jobs[index];
                      final jobDetailCubit = sl<JobDetailCubit>()
                        ..fetchJobDetail(appliedJob.jobsId);

                      return BlocBuilder<JobDetailCubit, JobDetailState>(
                        bloc: jobDetailCubit,
                        builder: (context, detailState) {
                          if (detailState is JobDetailLoading) {
                            return const SizedBox();
                          } else if (detailState is JobDetailFailure) {
                            return ListTile(
                              title: const Text("Failed to load job"),
                              subtitle: Text(detailState.error),
                            );
                          } else if (detailState is JobDetailSuccess) {
                            return JobCard(
                              appliedJob: appliedJob,
                              jobDetail: detailState.jobDetail,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}


