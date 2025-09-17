// ===== Job Tag =====
import 'package:flutter/material.dart';

class JobTag extends StatelessWidget {
  final String text;
  const JobTag(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffD6E4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xff387FFB), fontSize: 12),
      ),
    );
  }
}
