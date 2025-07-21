import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Raiff Dian 👋",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Create a better future for yourself here",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.notifications_none, color: Colors.black),
        ),
      ],
    );
  }
}
