
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/presentation/widgets/tag_suggested_job.dart';

class SuggestedJopItem extends StatelessWidget {
  const SuggestedJopItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff091A7A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(AppAssets.zoomLogo, height: 40, width: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Designer",
                    style: AppStyles.medium18.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Zoom • United States",
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
            direction: Axis.horizontal,

            children: [
              TagSuggestedJop(
                label: 'Fulltime',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: 'Remote',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
              TagSuggestedJop(
                label: 'Design',
                color: Colors.white.withValues(alpha: .14),
                textColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Text(
                  "\$12K-15K/Month",
                  style: AppStyles.medium18.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                width:
                    MediaQuery.of(context).size.width *
                    0.3, // 30% من عرض الشاشة
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xff3366FF),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
