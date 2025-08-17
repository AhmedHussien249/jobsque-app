import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_stepper.dart';

class ApplyJobTypeOfWork extends StatefulWidget {
  final int jobId;
  final String name;
  final String email;
  final String mobile;
  final String jobType; // <-- وصلناها من ApplyJobBiodata

  const ApplyJobTypeOfWork({
    super.key,
    required this.jobId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.jobType,
  });

  @override
  State<ApplyJobTypeOfWork> createState() => _ApplyJobTypeOfWorkState();
}

class _ApplyJobTypeOfWorkState extends State<ApplyJobTypeOfWork> {
  String? selectedWorkType;
  late final List<String> workTypes;

  @override
  void initState() {
    super.initState();
    workTypes = [widget.jobType]; // قيمة واحدة من JobDetailModel
    selectedWorkType = widget.jobType; // محددة افتراضياً
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply Job"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyJobStepper(
              isEdit: false,
              currentStep: 2,
              completedSteps: {1},
              stepTitles: const ["Biodata", "Type of Work", "Portfolio"],
            ),
            const SizedBox(height: 20),
            const Text("Type of Work", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...workTypes.map((type) {
              return RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: selectedWorkType,
                onChanged: (value) {
                  setState(() {
                    selectedWorkType = value;
                  });
                },
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedWorkType != null
                    ? () {
                        GoRouter.of(context).push(
                          '${AppRouter.kApplyJobUploadPortfolio}?jobId=${widget.jobId}&name=${widget.name}&email=${widget.email}&mobile=${widget.mobile}&workType=$selectedWorkType',
                        );
                      }
                    : null,
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
