import 'package:flutter/material.dart';

class SelectableItemModel {
  final String title;
  final IconData icon;

  const SelectableItemModel({
    required this.title,
    required this.icon,
  });

  static const List<SelectableItemModel> items = [
    SelectableItemModel(title: 'UI/UX Designer', icon: Icons.design_services),
    SelectableItemModel(title: 'Illustrator Designer', icon: Icons.brush),
    SelectableItemModel(title: 'Developer', icon: Icons.code),
    SelectableItemModel(title: 'Management', icon: Icons.business_center),
    SelectableItemModel(title: 'Information Technology', icon: Icons.computer),
    SelectableItemModel(title: 'Research and Analytics', icon: Icons.analytics),
  ];
}
