import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_state.dart';
import 'package:jobsque/features/home/presentation/widgets/filter_bottom_sheet.dart';
import 'package:jobsque/features/home/presentation/widgets/filter_button.dart';
import 'package:jobsque/features/home/presentation/widgets/recent_job_item.dart';
import 'package:jobsque/features/home/presentation/widgets/search_field.dart';
import 'package:jobsque/features/home/presentation/widgets/search_history_section.dart';

class SearchView extends StatefulWidget {
  final AppPreferences appPreferences;
  const SearchView({super.key, required this.appPreferences});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    searchHistory = widget.appPreferences.getSearchHistory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<JobsCubit>().fetchAllJobs();
      }
    });
  }

  void performSearch(String query) {
    final trimmedQuery = query.trim();
    if (!mounted) return;

    setState(() {
      searchQuery = trimmedQuery;
    });

    if (trimmedQuery.isEmpty) {
      context.read<JobsCubit>().fetchAllJobs();
    } else {
      context.read<JobsCubit>().searchJobs(trimmedQuery);
    }
  }

  void clearSearchHistory() async {
    await widget.appPreferences.clearSearchHistory();
    if (!mounted) return;
    setState(() {
      searchHistory.clear();
    });
  }

  void showFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        onApply: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFilterIcon = searchQuery.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.read<JobsCubit>().fetchAllJobs();
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: SearchField(
                        controller: searchController,
                        onChanged: performSearch,
                        onSearchPressed: () =>
                            performSearch(searchController.text),
                      ),
                    ),
                  ],
                ),
              ),

              if (searchQuery.isEmpty)
                SliverToBoxAdapter(
                  child: SearchHistorySection(
                    searchHistory: searchHistory,
                    onTap: (query) {
                      searchController.text = query;
                      performSearch(query);
                    },
                    onClear: clearSearchHistory,
                  ),
                ),

              if (showFilterIcon)
                SliverToBoxAdapter(child: FilterButton(onPressed: showFilter)),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              BlocBuilder<JobsCubit, JobsState>(
                builder: (context, state) {
                  if (state is JobsLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is JobsFailure) {
                    return SliverFillRemaining(
                      child: Center(child: Text('Error: ${state.error}')),
                    );
                  } else if (state is JobsSuccess) {
                    final jobs = state.jobs;
                    if (jobs.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.searchIlustration,
                                height: 142,
                                width: 173,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'No Search Found',
                                style: AppStyles.medium24,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Try searching with different keywords so we can show you',
                                textAlign: TextAlign.center,
                                style: AppStyles.regular16.copyWith(
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final job = jobs[index];
                        return RecentJobItem(
                          companyName: job.compName,
                          jobTitle: job.name,
                          location: job.location,
                          image: job.image,
                          salary: job.salary,
                          job: job,
                        );
                      }, childCount: jobs.length),
                    );
                  } else {
                    return const SliverFillRemaining(
                      child: Center(child: Text("Start typing to search jobs")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
