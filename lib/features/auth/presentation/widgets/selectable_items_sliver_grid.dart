import 'package:flutter/material.dart';
import 'package:jobsque/features/auth/data/models/selectable_items_model.dart';
import 'package:jobsque/features/auth/presentation/widgets/selectable_items.dart';

class SelectableItemSliverGrid extends StatefulWidget {
  const SelectableItemSliverGrid({super.key});

  @override
  State<SelectableItemSliverGrid> createState() =>
      _SelectableItemSliverGridState();
}

class _SelectableItemSliverGridState extends State<SelectableItemSliverGrid> {
  final Set<int> selectedIndex = {0, 5};
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: SelectableItemModel.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = SelectableItemModel.items[index];
        return SelectableItem(
          title: item.title,
          icon: item.icon,
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
    );
  }
}
