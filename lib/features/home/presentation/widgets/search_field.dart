import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final VoidCallback onSearchPressed;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search job...",
        prefixIcon: IconButton(
          icon: SvgPicture.asset(AppAssets.search, width: 20, height: 20),
          onPressed: onSearchPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xff9CA3AF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xff3366FF), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
    );
  }
}
