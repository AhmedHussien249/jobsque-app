import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class TagSuggestedJop extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const TagSuggestedJop({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tagWidth = (screenWidth - 50 * 2 - 8 * 2) / 3;

    return SizedBox(
      width: tagWidth,
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: AppStyles.regular12.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
