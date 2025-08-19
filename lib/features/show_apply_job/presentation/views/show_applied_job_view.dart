import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_bio_data.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_cubit.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_state.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_cubit.dart';
import 'package:jobsque/features/show_apply_job/presentation/view_model/cubit/show_applied_job_state.dart';

class AppliedJobsView extends StatefulWidget {
  const AppliedJobsView({super.key});

  @override
  State<AppliedJobsView> createState() => _AppliedJobsViewState();
}

class _AppliedJobsViewState extends State<AppliedJobsView> {
  late ShowAppliedJobCubit cubit;
  int selectedTab = 0; // 0 => Active, 1 => Rejected

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
          // ✅ Tabs (Active / Rejected)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                _buildTabButton("Active", 0),
                _buildTabButton("Rejected", 1),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ShowAppliedJobCubit, ShowAppliedJobState>(
              builder: (context, state) {
                if (state is ShowAppliedJobLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowAppliedJobFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is ShowAppliedJobSuccess) {
                  // فلترة حسب التاب
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
                            final jobDetail = detailState.jobDetail;

                            return _buildJobCard(appliedJob, jobDetail);
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

  // ✅ Tab Button
  Widget _buildTabButton(String title, int index) {
    final isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Color(0xff091A7A) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Job Card UI (زي الصورة)
  // ignore: strict_top_level_inference
  Widget _buildJobCard(appliedJob, jobDetail) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ApplyJobBiodata(
                appliedJob: appliedJob,
                jobId: appliedJob.jobsId,
                jobType: jobDetail.jobType,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Company & Job Title
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(jobDetail.image),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobDetail.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${jobDetail.compName} • ${jobDetail.location}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ✅ Tags (Fulltime / Remote)
              Row(
                children: [
                  _buildTag(jobDetail.jobTimeType),
                  const SizedBox(width: 8),
                  _buildTag(jobDetail.jobType),
                  const Spacer(),
                  Text(
                    DateFormat(
                      'dd/MM/yyyy',
                    ).format(DateTime.parse(appliedJob.createdAt)),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ✅ Stepper progress
              Row(
                children: [
                  _buildStep("1", "Biodata", true),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  _buildStep("2", "Type of work", true),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  _buildStep("3", "Upload portfolio", true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Tag Widget
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xffD6E4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xff387FFB), fontSize: 12),
      ),
    );
  }

  // ✅ Step Widget
  Widget _buildStep(String number, String label, bool done) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: done ? Color(0xff387FFB) : Colors.white,
          child: Text(
            number,
            style: TextStyle(
              color: done ? Colors.white :Color(0xff387FFB),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: done ? Color(0xff387FFB) : Colors.grey.shade600, // 👈 هنا التغيير
            fontSize: 12,
            fontWeight: done
                ? FontWeight.bold
                : FontWeight.normal, // 👈 عشان يبان واضح
          ),
        ),
      ],
    );
  }
}
