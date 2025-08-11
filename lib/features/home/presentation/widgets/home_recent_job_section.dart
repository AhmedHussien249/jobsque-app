import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_state.dart';
import 'package:jobsque/features/home/presentation/widgets/recent_job_item.dart';

class HomeRecentJobSection extends StatelessWidget {
  const HomeRecentJobSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Recent Job",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("View all", style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<JobsCubit, JobsState>(
          builder: (context, state) {
            if (state is JobsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is JobsSuccess) {
              return ListView.builder(
                itemBuilder: (_, index) => RecentJobItem(
                  companyName: state.jobs[index].compName,
                  jobTitle: state.jobs[index].name,
                  location: state.jobs[index].location,
                  image: state.jobs[index].image,
                  salary: state.jobs[index].salary,
                  job: state.jobs[index],
                ),
                itemCount: state.jobs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              );
            } else if (state is JobsFailure) {
              return Center(child: Text("Error: ${state.error}"));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
