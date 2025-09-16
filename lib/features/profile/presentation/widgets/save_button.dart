import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_cubit.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_state.dart';

class SaveButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController bioController;
  final TextEditingController addressController;
  final TextEditingController personalController;
  final TextEditingController phoneController;
  final Country? selectedCountry;

  const SaveButton({
    super.key,
    required this.nameController,
    required this.bioController,
    required this.addressController,
    required this.personalController,
    required this.phoneController,
    this.selectedCountry,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully!")),
            );
            context.read<ProfileCubit>().getPortfolio();
            Navigator.pop(context);
          } else if (state is EditProfileFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF3366FF),
            ),
            onPressed: state is EditProfileLoading
                ? null
                : () {
                    final queryParams = {
                      "name": nameController.text,
                      "bio": bioController.text,
                      "address": addressController.text,
                      "personal_detailed": personalController.text,
                      "mobile":
                          "${selectedCountry?.phoneCode ?? ""}${phoneController.text}",
                    };
                    context.read<ProfileCubit>().editProfile(
                      queryParams: queryParams,
                    );
                  },
            child: state is EditProfileLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    "Save",
                    style: AppStyles.medium16.copyWith(color: Colors.white),
                  ),
          );
        },
      ),
    );
  }
}
