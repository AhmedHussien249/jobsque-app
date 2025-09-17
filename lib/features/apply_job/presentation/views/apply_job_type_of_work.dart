import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_stepper.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

class ApplyJobTypeOfWorkView extends StatefulWidget {
  final int jobId;
  final String name;
  final String email;
  final String mobile;
  final String jobType;
  final AppliedJobModel? appliedJob;

  const ApplyJobTypeOfWorkView({
    super.key,
    required this.jobId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.jobType,
    this.appliedJob,
  });

  @override
  State<ApplyJobTypeOfWorkView> createState() => _ApplyJobTypeOfWorkViewState();
}

class _ApplyJobTypeOfWorkViewState extends State<ApplyJobTypeOfWorkView> {
  String? selectedWorkType;
  late final List<String> workTypes;

  @override
  void initState() {
    super.initState();
    workTypes = [widget.jobType];

    selectedWorkType = widget.appliedJob?.workType ?? widget.jobType;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.appliedJob != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Update Application" : "Apply Job"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyJobStepper(
              isEdit: isEdit,
              currentStep: 2,
              completedSteps: {1},
              stepTitles: const ["Biodata", "Type of Work", "Portfolio"],
            ),
            const SizedBox(height: 20),
            const Text(
              "Type of Work",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ...workTypes.map((type) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Radio<String>(
                          activeColor: Color(0xff3366FF),
                          value: type,
                          groupValue: selectedWorkType,
                          onChanged: (value) {
                            setState(() {
                              selectedWorkType = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      'CV.pdf • Portfolio.pdf',
                      style: AppStyles.medium14.copyWith(
                        color: Color(0xff6B7280),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3366FF),
                ),
                onPressed: selectedWorkType != null
                    ? () {
                        GoRouter.of(context).push(
                          '${AppRouter.kApplyJobUploadPortfolio}?jobId=${widget.jobId}&name=${widget.name}&email=${widget.email}&mobile=${widget.mobile}&workType=$selectedWorkType',
                        );
                      }
                    : null,
                child: Text(
                  isEdit ? "Update & Next" : "Next",
                  style: AppStyles.medium16.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
