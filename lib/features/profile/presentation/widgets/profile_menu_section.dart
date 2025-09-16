

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuItemData> items;

  const MenuSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        ...items.map((item) => ProfileMenuItem(data: item)).toList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MenuItemData {
  final String text;
  final String? iconUrl;
  final VoidCallback? onTap;

  MenuItemData({required this.text, this.iconUrl, this.onTap});
}

class ProfileMenuItem extends StatelessWidget {
  final MenuItemData data;
  const ProfileMenuItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: data.iconUrl != null ? SvgPicture.asset(data.iconUrl!) : null,
      title: Text(data.text),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: data.onTap,
    );
  }
}