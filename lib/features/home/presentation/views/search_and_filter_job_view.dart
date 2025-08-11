import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/widgets/custom_search_field.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_state.dart';
import 'package:jobsque/features/home/presentation/widgets/recent_job_item.dart';

class SearchAndFilterJobView extends StatelessWidget {
  SearchAndFilterJobView({super.key});

  final TextEditingController searchController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search & Filter Jobs")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<JobsCubit>().searchJobs(value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: salaryController,
              decoration: const InputDecoration(
                hintText: "Salary",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<JobsCubit>().filterJobs(
                  name: searchController.text,
                  location: locationController.text,
                  salary: salaryController.text,
                );
              },
              child: const Text("Apply Filter"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<JobsCubit, JobsState>(
                builder: (context, state) {
                  if (state is JobsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is JobsSuccess) {
                    return ListView.builder(
                      itemCount: state.jobs.length,
                      itemBuilder: (context, index) {
                        return RecentJobItem(
                          companyName: state.jobs[index].compName,
                          jobTitle: state.jobs[index].name,
                          location: state.jobs[index].location,
                          image: state.jobs[index].image,
                          salary: state.jobs[index].salary,
                          job: state.jobs[index],
                        );
                      },
                    );
                  } else if (state is JobsFailure) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
