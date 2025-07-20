import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class PreferedLocationTopSection extends StatefulWidget {
  const PreferedLocationTopSection({super.key});

  @override
  State<PreferedLocationTopSection> createState() =>
      _PreferedLocationTopSectionState();
}

class _PreferedLocationTopSectionState
    extends State<PreferedLocationTopSection> {
  bool isRemote = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Where are you preferred\nLocation?', style: AppStyles.medium24),
          const SizedBox(height: 8),
          Text(
            'Let us know, where is the work location you want at this time, so we can adjust it.',
            style: AppStyles.regular16.copyWith(color: const Color(0xff737379)),
          ),
          const SizedBox(height: 20),

          /// ✅ Toggle Button
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isRemote = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isRemote
                            ? const Color(0xff3366FF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Work From Office',
                          style: TextStyle(
                            color: !isRemote ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isRemote = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isRemote
                            ? const Color(0xff3366FF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Remote Work',
                          style: TextStyle(
                            color: isRemote ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Text(
            'Select the country you want for your job',
            style: AppStyles.regular16.copyWith(color: const Color(0xff737379)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
