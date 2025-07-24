import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/data/models/jobs_model.dart';
import 'package:jobsque/features/home/presentation/widgets/tag_suggested_job.dart';

class SuggestedJopItem extends StatelessWidget {
  final JobModel job;
  String buildShortText(String text, {int maxWords = 4}) {
    final words = text.split(' ');
    if (words.length <= maxWords) return text;
    return '${words.take(maxWords).join(' ')}...';
  }

  const SuggestedJopItem({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff091A7A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                job.image,
                height: 40,
                width: 40,
                errorBuilder: (_, _, _) {
                  return Image.asset(AppAssets.zoomLogo, height: 40, width: 40);
                },
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buildShortText(job.name, maxWords: 2),
                    style: AppStyles.medium18.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    buildShortText(
                      "${job.compName} • ${job.location}",
                      maxWords: 6,
                    ),
                    style: AppStyles.regular12.copyWith(
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                AppAssets.archiveMinus,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              TagSuggestedJop(
                label: job.jobTimeType,
                color: Colors.white.withValues(alpha: 0.14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: "Remote",
                color: Colors.white.withValues(alpha: 0.14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: job.jobType,
                color: Colors.white.withValues(alpha: 0.14),
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${job.salary}/ month",
                style: AppStyles.medium18.copyWith(color: Colors.white),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3366FF),
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {},
                  child: FittedBox(child: const Text("Apply now")),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
