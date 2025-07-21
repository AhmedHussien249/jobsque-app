import 'package:flutter/material.dart';

class HomeSuggestedJobSection extends StatelessWidget {
  const HomeSuggestedJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Suggested Job",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "View all",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xff3366FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Product Designer",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(height: 4),
              const Text("Zoom • United States", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  _JobTag(label: 'Fulltime'),
                  _JobTag(label: 'Remote'),
                  _JobTag(label: 'Design'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("\$12K-15K/Month", style: TextStyle(color: Colors.white)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xff3366FF),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: () {},
                    child: const Text("Apply now"),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _JobTag extends StatelessWidget {
  final String label;
  const _JobTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white24,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
