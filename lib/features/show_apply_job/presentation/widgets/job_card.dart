
// ===== Job Card =====
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_bio_data.dart';
import 'package:jobsque/features/show_apply_job/presentation/widgets/job_header.dart';
import 'package:jobsque/features/show_apply_job/presentation/widgets/job_step.dart';
import 'package:jobsque/features/show_apply_job/presentation/widgets/job_tag.dart';

class JobCard extends StatelessWidget {
  final appliedJob;
  final jobDetail;

  const JobCard({super.key, required this.appliedJob, required this.jobDetail});

  @override
  Widget build(BuildContext context) {
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
              JobHeader(jobDetail: jobDetail),
              const SizedBox(height: 12),
              Row(
                children: [
                  JobTag(jobDetail.jobTimeType),
                  const SizedBox(width: 8),
                  JobTag(jobDetail.jobType),
                  const Spacer(),
                  Text(
                    DateFormat('dd/MM/yyyy').format(DateTime.parse(appliedJob.createdAt)),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  JobStep(number: "1", label: "Biodata", done: true),
                  Expanded(child: Divider(color: Color(0xffE0E0E0))),
                  JobStep(number: "2", label: "Type of work", done: true),
                  Expanded(child: Divider(color: Color(0xffE0E0E0))),
                  JobStep(number: "3", label: "Upload portfolio", done: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}