import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class JobDetailBottom extends StatelessWidget {
  const JobDetailBottom({super.key, required this.jobId, required this.jobType});
  final int jobId;
  final String jobType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff3366FF),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // Pass jobType safely
          final safeJobType = jobType.isNotEmpty ? jobType : "Full-time";
          GoRouter.of(context).push(
            '${AppRouter.kApplyJobBioData}?jobId=$jobId&jobType=$safeJobType',
          );
        },
        child: Text(
          "Apply Now",
          style: AppStyles.medium16.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
