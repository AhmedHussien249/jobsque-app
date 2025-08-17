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
    required this.currentStep,
    required this.completedSteps,
    required this.stepTitles, required this.isEdit, this.appliedJob,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stepTitles.length, (index) {
        final stepNumber = index + 1;
        final isCompleted = completedSteps.contains(stepNumber);
        final isCurrent = currentStep == stepNumber;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: isCompleted || isCurrent
                        ? Colors.blue
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
                  if (index != stepTitles.length - 1)
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: isCompleted || isCurrent
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                stepTitles[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
