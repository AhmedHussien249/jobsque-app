import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  const CustomSearchField({super.key, this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search,size: 24,),
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
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}