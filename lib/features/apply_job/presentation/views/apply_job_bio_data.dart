import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/apply_job/presentation/views/apply_job_stepper.dart';
import 'package:jobsque/features/show_apply_job/data/models/show_applied_job_model.dart';

class ApplyJobBiodata extends StatefulWidget {
  final int jobId;
  final String jobType;
  final AppliedJobModel? appliedJob;

  const ApplyJobBiodata({
    super.key,
    required this.jobId,
    required this.jobType,
    this.appliedJob,
  });

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
  void initState() {
    super.initState();

    if (widget.appliedJob != null) {
      nameController.text = widget.appliedJob?.name ?? "";
      emailController.text = widget.appliedJob?.email ?? "";
      phoneController.text = widget.appliedJob?.mobile ?? "";

      selectedCountry = Country(
        phoneCode: widget.appliedJob?.mobile.substring(0, 2) ?? "20",
        countryCode: "EG",
        name: "Egypt",
        displayName: "Egypt",
        displayNameNoCountryCode: "Egypt",
        e164Sc: 0,
        geographic: true,
        level: 1,
        example: "20123456789",
        fullExampleWithPlusSign: "+20123456789",
        e164Key: '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.appliedJob != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEdit ? "Edit Application" : "Apply Job"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ApplyJobStepper(
                        isEdit: isEdit,
                        appliedJob: widget.appliedJob,
                        currentStep: 1,
                        completedSteps: {},
                        stepTitles: const [
                          "Biodata",
                          "Type of Work",
                          "Portfolio",
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Full Name
                      const Text("Full Name"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        decoration: _inputDecoration("Enter your full name"),
                        validator: (value) => value == null || value.isEmpty
                            ? "Please enter your name"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      const Text("Email"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration("Enter your email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Mobile
                      const Text("Mobile"),
                      const SizedBox(height: 8),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFF9CA3AF)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    setState(() => selectedCountry = country);
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedCountry?.flagEmoji ?? "🇪🇬",
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const Icon(Icons.arrow_drop_down, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 1,
                              color: const Color(0XFF9CA3AF),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "123 456 789",
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? "Please enter your mobile number"
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3366FF),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            GoRouter.of(context).push(
                              '${AppRouter.kApplyTypeOfWork}?jobId=${widget.jobId}&name=${nameController.text}&email=${emailController.text}&mobile=+${selectedCountry?.phoneCode ?? "20"}${phoneController.text}&jobType=${widget.jobType}',
                            );
                          }
                        },
                        child: Text(
                          isEdit ? "Update & Next" : "Next",
                          style: AppStyles.medium16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xff9CA3AF), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xff3366FF), width: 2),
      ),
    );
  }
}
