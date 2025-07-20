import 'package:flutter/material.dart';
import 'package:jobsque/features/auth/presentation/widgets/prefered_location_bottom_section.dart';
import 'package:jobsque/features/auth/presentation/widgets/prefered_location_top_section.dart';

class PreferedLocationContent extends StatelessWidget {
  const PreferedLocationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: const PreferedLocationTopSection()),

          /// ✅ Country Grid using SliverToBoxAdapter + Wrap
          SliverToBoxAdapter(child: const PreferedLocationButtomSection()),

          /// ✅ Next Button
        ],
      ),
    );
  }
}
