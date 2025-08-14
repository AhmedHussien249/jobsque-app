import 'package:flutter/material.dart';
import 'package:jobsque/features/job_detail/data/models/job_detail_model.dart';

class JobDetailHeader extends StatelessWidget {
  final JobDetailModel job;

  const JobDetailHeader({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(job.image),
        ),
        const SizedBox(height: 8),
        // Job Title
        Text(
          job.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "${job.compName} • ${job.location}",
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Tags
        Wrap(
          spacing: 8,
          children: [
            _buildTag(job.jobTimeType),
            _buildTag(job.jobType),
            
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      label: Text(text,style:TextStyle(color:  Color(0xff3366FF),)),
      backgroundColor: const Color(0xffD6E4FF),
    );
  }
}
