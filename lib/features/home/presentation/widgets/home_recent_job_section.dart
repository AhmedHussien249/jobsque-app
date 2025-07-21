import 'package:flutter/material.dart';

class HomeRecentJobSection extends StatelessWidget {
  const HomeRecentJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Recent Job",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "View all",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _RecentJobItem(
          companyName: "Twitter",
          jobTitle: "Senior UI Designer",
          location: "Jakarta, Indonesia",
        ),
        const SizedBox(height: 12),
        _RecentJobItem(
          companyName: "Discord",
          jobTitle: "Senior UX Designer",
          location: "Jakarta, Indonesia",
        ),
      ],
    );
  }
}

class _RecentJobItem extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;

  const _RecentJobItem({
    required this.companyName,
    required this.jobTitle,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.blue[50],
        child: Icon(Icons.business, color: Colors.blue),
      ),
      title: Text(jobTitle, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('$companyName • $location'),
      trailing: Icon(Icons.bookmark_border),
    );
  }
}
