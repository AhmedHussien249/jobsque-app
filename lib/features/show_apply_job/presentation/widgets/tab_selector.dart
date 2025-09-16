
// ===== Tab Selector =====
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const TabSelector({super.key, required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton("Active", 0),
          _buildTabButton("Rejected", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff091A7A) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}