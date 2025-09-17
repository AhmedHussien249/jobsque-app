import 'package:flutter/material.dart';

class SearchHistorySection extends StatelessWidget {
  final List<String> searchHistory;
  final void Function(String) onTap;
  final VoidCallback onClear;

  const SearchHistorySection({
    super.key,
    required this.searchHistory,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (searchHistory.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Recent Searches",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: searchHistory.map((query) {
            return ActionChip(
              avatar: const Icon(Icons.history, color: Color(0xFF3366FF)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              label: Text(query),
              backgroundColor: const Color(0xffD6E4FF),
              labelStyle: const TextStyle(
                color: Color(0xFF3366FF),
                fontSize: 14,
              ),
              onPressed: () => onTap(query),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onClear,
          child: const Text(
            "Clear Search History",
            style: TextStyle(color: Color(0xFF3366FF), fontSize: 14),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
