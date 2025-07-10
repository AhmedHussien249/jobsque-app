
import 'package:flutter/material.dart';
import 'package:jobsque/features/auth/presentation/widgets/selectable_items.dart';

class SelectableItemSliverGrid extends StatefulWidget {
  const SelectableItemSliverGrid({super.key});

  @override
  State<SelectableItemSliverGrid> createState() => _SelectableItemSliverGridState();
}

class _SelectableItemSliverGridState extends State<SelectableItemSliverGrid> {
  final List<String> options = [
    'UI/UX Designer',
    'Illustrator Designer',
    'Developer',
    'Management',
    'Information Technology',
    'Research and Analytics',
  ];

  final List<IconData> icons = [
    Icons.design_services,
    Icons.brush,
    Icons.code,
    Icons.business_center,
    Icons.computer,
    Icons.analytics,
  ];

  final Set<int> selectedIndex = {0, 5};
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SliverGrid.builder(
        itemCount: options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          return SelectableItem(
            title: options[index],
            icon: icons[index],
            isSelected: selectedIndex.contains(index),
            onTap: () {
              setState(() {
                if (selectedIndex.contains(index)) {
                  selectedIndex.remove(index);
                } else {
                  selectedIndex.add(index);
                }
              });
            },
          );
        },
      ),
    );
  }
}
