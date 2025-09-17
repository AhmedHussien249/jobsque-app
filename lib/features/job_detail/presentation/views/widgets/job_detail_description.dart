import 'package:flutter/material.dart';
import 'package:jobsque/features/job_detail/data/models/job_detail_model.dart';

class JobDetailDescription extends StatelessWidget {
  final JobDetailModel job;

  const JobDetailDescription({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text("Job Description", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(job.jobDescription),
      ],
    );
  }
}
