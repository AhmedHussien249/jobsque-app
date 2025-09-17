import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';

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
      child: Text(label, style: AppStyles.regular12.copyWith(color: textColor)),
    );
  }
}
