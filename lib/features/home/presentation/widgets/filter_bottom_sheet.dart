

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobsque/features/home/presentation/view_model/cubits/suggested_job_cubits/job_cubit.dart';
import 'package:jobsque/features/home/presentation/widgets/custom_filter_text_field.dart';

class FilterBottomSheet extends StatefulWidget {
  final VoidCallback onApply;

  const FilterBottomSheet({super.key, required this.onApply});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController jobTitleFilterController =
      TextEditingController();
  final TextEditingController locationFilterController =
      TextEditingController();
  final TextEditingController salaryFilterController = TextEditingController();

  final Set<String> selectedJobTypes = {};

  final List<String> jobTypeOptions = [
    "Full Time",
    "Remote",
    "Contract",
    "Part Time",
    "Onsite",
    "Internship",
  ];

  void resetFilters() {
    setState(() {
      jobTitleFilterController.clear();
      locationFilterController.clear();
      salaryFilterController.clear();
      selectedJobTypes.clear();
    });
  }

  void applyFilter() {
    final nameFilter = jobTitleFilterController.text.trim().isEmpty
        ? null
        : jobTitleFilterController.text.trim();
    final locationFilter = locationFilterController.text.trim().isEmpty
        ? null
        : locationFilterController.text.trim();
    final salaryFilter = salaryFilterController.text.trim().isEmpty
        ? null
        : salaryFilterController.text.trim();

    context.read<JobsCubit>().filterJobs(
      name: nameFilter,
      location: locationFilter,
      salary: salaryFilter,
      jobTimeTypes: selectedJobTypes.isEmpty ? null : selectedJobTypes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  "Set Filter",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    resetFilters();
                  },
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Color(0xFF3366FF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Job Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomFilterTextField(
              textFilterController: jobTitleFilterController,
              label: 'Job Title',
              onChanged: (_) => setState(() {}),
              prefixIcon: const Icon(Icons.work_outline),
            ),
            const SizedBox(height: 16),
            Text(
              "Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomFilterTextField(
              textFilterController: locationFilterController,
              label: 'City Or Country',
              onChanged: (_) => setState(() {}),
              prefixIcon: const Icon(Icons.location_on_outlined),
            ),
            const SizedBox(height: 15),
            Text(
              "Salary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CustomFilterTextField(
              textFilterController: salaryFilterController,
              label: 'Salary (in USD)',
              onChanged: (_) {
                setState(() {});
              },
              prefixIcon: const Icon(Icons.attach_money_outlined),
            ),
            const SizedBox(height: 16),
            const Text(
              "Job Type",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 16,
              children: jobTypeOptions.map((label) {
                final isSelected = selectedJobTypes.contains(label);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedJobTypes.remove(label);
                      } else {
                        selectedJobTypes.add(label);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xffD6E4FF)
                          : const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF3366FF)
                            : Color(0xff9CA3AF),
                      ),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF3366FF)
                            : Color(0xff9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 158.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF3366FF),
              ),
              onPressed: () {
                applyFilter();
                widget.onApply();
              },
              child: const Text(
                "Apply Filter",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}