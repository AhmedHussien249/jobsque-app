import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/service_locator.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${sl<AppPreferences>().getUserName()} 👋",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Create a better future for yourself here",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: SvgPicture.asset(
            AppAssets.notficationapp,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}
