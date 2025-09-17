import 'package:flutter/material.dart';
import 'package:jobsque/features/job_detail/data/models/job_detail_model.dart';

class JobDetailSkills extends StatelessWidget {
  final JobDetailModel job;

  const JobDetailSkills({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final skills = job.jobSkill.split("\n");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text("Skill Required", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: skills.map((skill) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 6),
                ),
                const SizedBox(width: 6),
                Expanded(child: Text(skill)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
