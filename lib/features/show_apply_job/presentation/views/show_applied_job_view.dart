import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_bio_data.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';
import '../view_model/cubit/show_applied_job_cubit.dart';
import '../view_model/cubit/show_applied_job_state.dart';

class AppliedJobsView extends StatefulWidget {
  const AppliedJobsView({super.key});

  @override
  State<AppliedJobsView> createState() => _AppliedJobsViewState();
}

class _AppliedJobsViewState extends State<AppliedJobsView> {
  late ShowAppliedJobCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ShowAppliedJobCubit>();
    cubit.getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Applied Jobs')),
      body: BlocBuilder<ShowAppliedJobCubit, ShowAppliedJobState>(
        builder: (context, state) {
          if (state is ShowAppliedJobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShowAppliedJobFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is ShowAppliedJobSuccess) {
            final jobs = state.jobs;
            if (jobs.isEmpty) {
              return const Center(child: Text('No applied jobs yet'));
            }
            return ListView.separated(
              itemCount: jobs.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return ListTile(
                  title: Text(job.name),
                  subtitle: Text('Job ID: ${job.jobsId} • ${job.workType}'),
                  trailing: Text(
                    job.reviewed == 0
                        ? '⏳ Pending'
                        : (job.accept == true ? '✅ Accepted' : '❌ Rejected'),
                    style: TextStyle(
                      color: job.reviewed == 0
                          ? Colors.orange
                          : (job.accept == true ? Colors.green : Colors.red),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ApplyJobBiodata(appliedJob: job, jobId: job.jobsId, jobType: job.workType,),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
  

class AppliedJobDetailsView extends StatelessWidget {
  final AppliedJobModel appliedJob;

  const AppliedJobDetailsView({super.key, required this.appliedJob});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application #${appliedJob.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Name: ${appliedJob.name}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Email: ${appliedJob.email}'),
            const SizedBox(height: 8),
            Text('Mobile: ${appliedJob.mobile}'),
            const SizedBox(height: 8),
            Text('Work Type: ${appliedJob.workType}'),
            const SizedBox(height: 8),
            Text('CV File: ${appliedJob.cvFile ?? "Not provided"}'),
            const SizedBox(height: 8),
            Text('Other File: ${appliedJob.otherFile ?? "Not provided"}'),
            const SizedBox(height: 8),
            Text('Job ID: ${appliedJob.jobsId}'),
            const SizedBox(height: 8),
            Text('Status: ${appliedJob.reviewed == 0 ? "Pending" : (appliedJob.accept == true ? "Accepted" : "Rejected")}'),
            const SizedBox(height: 12),
            Text('Applied at: ${appliedJob.createdAt}'),
            
          ],
        ),
      ),
    );
  }
}
