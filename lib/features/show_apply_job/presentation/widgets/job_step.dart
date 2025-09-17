// ===== Job Step =====
import 'package:flutter/material.dart';

class JobStep extends StatelessWidget {
  final String number;
  final String label;
  final bool done;

  const JobStep({
    super.key,
    required this.number,
    required this.label,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: done ? const Color(0xff387FFB) : Colors.white,
          child: Text(
            number,
            style: TextStyle(
              color: done ? Colors.white : const Color(0xff387FFB),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: done ? const Color(0xff387FFB) : Colors.grey,
            fontSize: 12,
            fontWeight: done ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
