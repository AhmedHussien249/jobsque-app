import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_assets.dart';

class AuthCustomAppBar extends StatelessWidget {
  const AuthCustomAppBar({super.key, required this.hasBackButton});
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        hasBackButton
            ? InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff292D32),
                ),
              )
            : const Spacer(),
        Image.asset(AppAssets.logo, height: 19, width: 81),
      ],
    );
  }
}