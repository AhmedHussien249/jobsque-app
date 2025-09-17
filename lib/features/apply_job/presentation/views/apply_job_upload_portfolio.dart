import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_cubit.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_state.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_stepper.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

class ApplyJobUploadPortfolio extends StatefulWidget {
  final int jobId;
  final String name;
  final String email;
  final String mobile;
  final String workType;
  final AppliedJobModel? appliedJob;

  const ApplyJobUploadPortfolio({
    super.key,
    required this.jobId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.workType,
    this.appliedJob,
  });

  @override
  State<ApplyJobUploadPortfolio> createState() =>
      _ApplyJobUploadPortfolioState();
}

class _ApplyJobUploadPortfolioState extends State<ApplyJobUploadPortfolio> {
  String? cvFile;
  String? otherFile;

  @override
  void initState() {
    super.initState();

    cvFile = widget.appliedJob?.cvFile;
    otherFile = widget.appliedJob?.otherFile;
  }

  Future<void> pickFile({required bool isCV}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        if (isCV) {
          cvFile = result.files.single.path;
        } else {
          otherFile = result.files.single.path;
        }
      });
    }
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyJobStepper(
              isEdit: isEdit,
              currentStep: 3,
              completedSteps: {1, 2},
              stepTitles: const ["Biodata", "Type of Work", "Portfolio"],
            ),
            const SizedBox(height: 24),

            const Text(
              "Upload Portfolio",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// ---- Upload CV ----
            /// -------- Upload CV --------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload CV",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => pickFile(isCV: true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            cvFile != null
                                ? cvFile!.split('/').last
                                : "Choose your CV file",
                            style: TextStyle(
                              fontSize: 15,
                              color: cvFile != null
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          cvFile != null && cvFile!.endsWith(".pdf")
                              ? Icons.picture_as_pdf
                              : Icons.description,
                          color: cvFile != null && cvFile!.endsWith(".pdf")
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// -------- Upload Portfolio --------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload Portfolio (Optional)",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => pickFile(isCV: false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            otherFile != null
                                ? otherFile!.split('/').last
                                : "Choose your Portfolio file",
                            style: TextStyle(
                              fontSize: 15,
                              color: otherFile != null
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          otherFile != null && otherFile!.endsWith(".pdf")
                              ? Icons.picture_as_pdf
                              : Icons.description,
                          color:
                              otherFile != null && otherFile!.endsWith(".pdf")
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// ---- Submit Button with Cubit ----
            BlocConsumer<ApplyJobCubit, ApplyJobState>(
              listener: (context, state) {
                if (state is ApplyJobSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit
                            ? "Updated Successfully ✅"
                            : "Applied Successfully ✅",
                      ),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (state is ApplyJobFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is ApplyJobLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3366FF),
                    ),
                    onPressed: cvFile != null
                        ? () {
                            context.read<ApplyJobCubit>().applyJob(
                              cvFilePath: cvFile!,
                              otherFilePath: otherFile ?? "",
                              name: widget.name,
                              email: widget.email,
                              mobile: widget.mobile,
                              workType: widget.workType,
                              jobsId: widget.jobId,
                              userId: 1,
                            );
                          }
                        : null,
                    child: Text(
                      isEdit ? "Update Application" : "Submit Application",
                      style: AppStyles.medium16.copyWith(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
