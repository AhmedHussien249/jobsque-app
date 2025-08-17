import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_cubit.dart';
import 'package:jobsque/features/job_detail/presentation/view_model/cubits/job_detail_state.dart';
import 'package:jobsque/features/job_detail/presentation/views/widgets/job_details_tab_bar.dart';

import 'widgets/job_detail_bottom.dart';
import 'widgets/job_detail_description.dart';
import 'widgets/job_detail_header.dart';
import 'widgets/job_detail_skills.dart';

class JobDetailView extends StatefulWidget {
  final int jobId;
  final String jobType;

  const JobDetailView({super.key, required this.jobId, required this.jobType});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<JobDetailCubit>().fetchJobDetail(widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Job Detail",
          style: AppStyles.medium20.copyWith(color: const Color(0xff111827)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppAssets.saved),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<JobDetailCubit, JobDetailState>(
        builder: (context, state) {
          if (state is JobDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobDetailFailure) {
            return Center(child: Text(state.error));
          } else if (state is JobDetailSuccess) {
            final job = state.jobDetail;

            // Safety for null jobType
            final jobTypeSafe = job.jobType.isNotEmpty ? job.jobType : "Full-time";

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      JobDetailHeader(job: job),
                      JobDetailTabBar(
                        selectedIndex: selectedTab,
                        onTabSelected: (index) {
                          setState(() => selectedTab = index);
                        },
                      ),
                      if (selectedTab == 0) ...[
                        JobDetailDescription(job: job),
                        JobDetailSkills(job: job),
                        const SizedBox(height: 80),
                      ] else ...[
                        const SizedBox(height: 16),
                        CompanyInformation(
                          email: job.compEmail.isNotEmpty ? job.compEmail : "N/A",
                          website: job.compWebsite.isNotEmpty ? job.compWebsite : "N/A",
                          aboutCompany: job.aboutComp.isNotEmpty ? job.aboutComp : "N/A",
                        ),
                        const SizedBox(height: 80),
                      ],
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: JobDetailBottom(jobId: job.id, jobType: jobTypeSafe),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class CompanyInformation extends StatelessWidget {
  const CompanyInformation({super.key, required this.email, required this.website, required this.aboutCompany});
  final String email;
  final String website;
  final String aboutCompany;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact Us', style: AppStyles.medium14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('email'), Text(email, overflow: TextOverflow.ellipsis)],
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('website'), Text(website, overflow: TextOverflow.ellipsis)],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('About Company', style: AppStyles.medium14),
        const SizedBox(height: 8),
        Text(
          aboutCompany,
          style: AppStyles.regular12.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
