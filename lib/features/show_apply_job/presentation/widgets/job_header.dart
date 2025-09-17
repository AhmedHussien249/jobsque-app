// ===== Job Header =====
import 'package:flutter/material.dart';

class JobHeader extends StatelessWidget {
  final jobDetail;
  const JobHeader({super.key, required this.jobDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(jobDetail.image),
          radius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jobDetail.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "${jobDetail.compName} • ${jobDetail.location}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
      ],
    );
  }
}
