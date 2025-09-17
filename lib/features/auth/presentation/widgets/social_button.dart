import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_styles.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.asset, required this.label});
  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffD1D5DB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(asset, height: 16, width: 16),
          const SizedBox(width: 2),
          Text(
            label,
            style: AppStyles.medium14.copyWith(color: const Color(0xff363F5E)),
          ),
        ],
      ),
    );
  }
}
