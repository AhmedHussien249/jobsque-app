import 'package:flutter/material.dart';
import 'package:jobsque/core/widgets/custom_search_field.dart';
import 'package:jobsque/features/home/presentation/widgets/home_header_section.dart';
import 'package:jobsque/features/home/presentation/widgets/home_recent_job_section.dart';
import 'package:jobsque/features/home/presentation/widgets/home_suggested_job_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeaderSection(),
          const SizedBox(height: 20),
          CustomSearchField(),
          const SizedBox(height: 24),
          const HomeSuggestedJobSection(),
          const SizedBox(height: 24),
          const HomeRecentJobSection(),
        ],
      ),
    );
  }
}