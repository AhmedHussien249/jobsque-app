import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/features/home/presentation/widgets/recent_job_item.dart';

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

