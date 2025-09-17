import 'package:flutter/material.dart';

class CustomFilterTextField extends StatelessWidget {
  const CustomFilterTextField({
    super.key,
    required this.textFilterController,
    required this.label,
    this.onChanged,
    this.prefixIcon,
  });
  final TextEditingController textFilterController;
  final String label;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      controller: textFilterController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xff9CA3AF), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xff3366FF), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
