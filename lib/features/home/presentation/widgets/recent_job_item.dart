import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';
import 'package:jobsque/features/home/presentation/widgets/tag_recent_job.dart';

class RecentJobItem extends StatelessWidget {
  final JobModel job;
  String buildShortText(String text, {int maxWords = 4}) {
    final words = text.split(' ');
    if (words.length <= maxWords) return text;
    return '${words.take(maxWords).join(' ')}...';
  }

  final String image;
  final String companyName;
  final String jobTitle;
  final String location;
  final String salary;

  const RecentJobItem({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.image,
    required this.salary,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(image, height: 48, width: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(jobTitle, style: AppStyles.medium16),
                    const SizedBox(height: 4),
                    Text(
                      "$companyName • $location",
                      style: AppStyles.regular12.copyWith(
                        color: const Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(AppAssets.saved, width: 24, height: 24),
            ],
          ),

          const SizedBox(height: 12),

          /// Tags + Salary Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الجزء الخاص بالـ Tags
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagRecentJob(
                      label: job.jobTimeType,
                      color: Color(0xffD6E4FF),
                      textColor: Color(0xff3366FF),
                    ),
                    const TagRecentJob(
                      label: 'Remote',
                      color: Color(0xffD6E4FF),
                      textColor: Color(0xff3366FF),
                    ),
                    TagRecentJob(
                      label: job.jobType,
                      color: Color(0xffD6E4FF),
                      textColor: Color(0xff3366FF),
                    ),
                  ],
                ),
              ),

              // الجزء الخاص بالراتب
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                 "\$$salary",
                  style: AppStyles.medium16.copyWith(
                    color: const Color(0xff2E8E18),
                  ),
                ),
                Text(
                  '/Month',
                  style: AppStyles.regular12.copyWith(
                    color: const Color(0xff6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
