import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        ProfileStatItem(title: "Applied", value: "0"),
        ProfileStatItem(title: "Reviewed", value: "0"),
        ProfileStatItem(title: "Contacted", value: "0"),
      ],
    );
  }
}

class ProfileStatItem extends StatelessWidget {
  final String title;
  final String value;
  const ProfileStatItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
