import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_cubit.dart';
import 'package:jobsque/features/apply_job/presentation/view_model/cubit/apply_job_state.dart';
import 'apply_job_stepper.dart';
import 'package:file_picker/file_picker.dart';

class ApplyJobUploadPortfolio extends StatefulWidget {
  final int jobId;
  final String name;
  final String email;
  final String mobile;
  final String workType;

  const ApplyJobUploadPortfolio({
    super.key,
    required this.jobId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.workType,
  });

  @override
  State<ApplyJobUploadPortfolio> createState() => _ApplyJobUploadPortfolioState();
}

class _ApplyJobUploadPortfolioState extends State<ApplyJobUploadPortfolio> {
  String? cvFile;
  String? otherFile;

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
    return Scaffold(
      appBar: AppBar(title: const Text("Apply Job"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyJobStepper(
              isEdit: false,
              currentStep: 3,
              completedSteps: {1, 2},
              stepTitles: const ["Biodata", "Type of Work", "Portfolio"],
            ),
            const SizedBox(height: 24),

            const Text("Upload Portfolio",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            /// ---- Upload CV ----
            GestureDetector(
              onTap: () => pickFile(isCV: true),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cvFile != null ? cvFile!.split('/').last : "Upload CV",
                        style: const TextStyle(fontSize: 16)),
                    const Icon(Icons.upload_file, color: Colors.blue),
                  ],
                ),
              ),
            ),

            /// ---- Upload Portfolio ----
            GestureDetector(
              onTap: () => pickFile(isCV: false),
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(otherFile != null
                        ? otherFile!.split('/').last
                        : "Upload Portfolio (Optional)",
                        style: const TextStyle(fontSize: 16)),
                    const Icon(Icons.upload_file, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// ---- Submit Button with Cubit ----
            BlocConsumer<ApplyJobCubit, ApplyJobState>(
              listener: (context, state) {
                if (state is ApplyJobSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Applied Successfully ✅")));
                  Navigator.popUntil(context, (route) => route.isFirst);
                } else if (state is ApplyJobFailure) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is ApplyJobLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cvFile != null
                        ? () {
                            context.read<ApplyJobCubit>().applyJob(
                                  cvFilePath: cvFile!,
                                  otherFilePath: otherFile??"",
                                  name: widget.name,
                                  email: widget.email,
                                  mobile: widget.mobile,
                                  workType: widget.workType,
                                  jobsId: widget.jobId,
                                  userId: 1, // استخدم الـ userId الفعلي هنا
                                );
                          }
                        : null,
                    child: const Text("Submit Application"),
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
