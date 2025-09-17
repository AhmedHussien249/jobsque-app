import 'package:flutter/material.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

class ApplyJobStepper extends StatelessWidget {
  final bool isEdit;
  final AppliedJobModel? appliedJob;
  final int currentStep;
  final Set<int> completedSteps;
  final List<String> stepTitles;

  const ApplyJobStepper({
    super.key,
    required this.isEdit,
    this.appliedJob,
    required this.currentStep,
    required this.completedSteps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(stepTitles.length * 2 - 1, (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;
              final stepNumber = stepIndex + 1;
              final isCompleted = completedSteps.contains(stepNumber);
              final isCurrent = currentStep == stepNumber;

              return Expanded(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: isCompleted || isCurrent
                      ? Color(0xff3366FF)
                      : Colors.grey.shade300,
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : Text(
                          "$stepNumber",
                          style: TextStyle(
                            color: isCurrent ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            } else {
              return Expanded(
                child: Container(height: 2, color: Colors.grey.shade300),
              );
            }
          }),
        ),

        const SizedBox(height: 6),

        Row(
          children: List.generate(stepTitles.length * 2 - 1, (index) {
            if (index.isEven) {
              final stepIndex = index ~/ 2;
              final stepNumber = stepIndex + 1;
              final isCurrent = currentStep == stepNumber;

              return Expanded(
                child: Text(
                  stepTitles[stepIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCurrent ? Color(0xff3366FF) : Colors.grey,
                  ),
                ),
              );
            } else {
              return const Expanded(child: SizedBox());
            }
          }),
        ),
      ],
    );
  }
}
