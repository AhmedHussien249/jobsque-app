import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class HomeRecentJobSection extends StatelessWidget {
  const HomeRecentJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Recent Job",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("View all", style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 12),
        const RecentJobItem(
          companyName: "Twitter",
          jobTitle: "Senior UI Designer",
          location: "Jakarta, Indonesia",
          image: AppAssets.twitterLogo,
          salary: '\$15K',
        ),
        const SizedBox(height: 12),
        const RecentJobItem(
          companyName: "Discord",
          jobTitle: "Senior UX Designer",
          location: "Jakarta, Indonesia",
          image: AppAssets.discordLogo,
          salary: '\$15K',
        ),
      ],
    );
  }
}

class RecentJobItem extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:Colors.white,
      
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(image, height: 48, width: 48),
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
              SvgPicture.asset(
                AppAssets.saved,
                width: 24,
                height: 24,
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Tags + Salary Row
          Row(
            children: [
              const TagRecentJob(
                label: 'Fulltime',
                color: Color(0xffD6E4FF),
                textColor: Color(0xff3366FF),
              ),
              const SizedBox(width: 8),
              const TagRecentJob(
                label: 'Remote',
                color: Color(0xffD6E4FF),
                textColor: Color(0xff3366FF),
              ),
              const SizedBox(width: 8),
              const TagRecentJob(
                label: 'Senior',
                color: Color(0xffD6E4FF),
                textColor: Color(0xff3366FF),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    salary,
                    style: AppStyles.medium16.copyWith(
                      color: const Color(0xff2E8E18),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '/Month',
                    style: AppStyles.regular12.copyWith(
                      color: const Color(0xff6B7280),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TagRecentJob extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const TagRecentJob({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppStyles.regular12.copyWith(color: textColor),
      ),
    );
  }
}
