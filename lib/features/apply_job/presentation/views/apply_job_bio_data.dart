import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';
import 'apply_job_stepper.dart';
import 'package:country_picker/country_picker.dart';

class ApplyJobBiodata extends StatefulWidget {
  final int jobId;
  final String jobType;
  final AppliedJobModel? appliedJob;
  

  const ApplyJobBiodata({super.key, required this.jobId, required this.jobType, this.appliedJob});

  @override
  State<ApplyJobBiodata> createState() => _ApplyJobBiodataState();
}

class _ApplyJobBiodataState extends State<ApplyJobBiodata> {
  Country? selectedCountry;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply Job"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ApplyJobStepper(
                isEdit: false,
                currentStep: 1,
                completedSteps: {},
                stepTitles: const ["Biodata", "Type of Work", "Portfolio"],
              ),
              const SizedBox(height: 20),
              const Text("Full Name"),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Enter your full name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your name";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Please enter your email";
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return "Enter a valid email";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text("Mobile"),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(selectedCountry?.flagEmoji ?? "🇪🇬", style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 6),
                                Text(
                                  "+${selectedCountry?.phoneCode ?? "20"}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "123 456 789",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Please enter your mobile number";
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      GoRouter.of(context).push(
                        '${AppRouter.kApplyTypeOfWork}?jobId=${widget.jobId}&name=${nameController.text}&email=${emailController.text}&mobile=+${selectedCountry?.phoneCode ?? "20"}${phoneController.text}&jobType=${widget.jobType}',
                      );
                    }
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
