import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_image_picker.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_input_field.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_text_field.dart';
import 'package:jobsque/features/profile/presentation/widgets/save_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _personalDetailedController =
      TextEditingController();

  Country? selectedCountry;
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfileImagePicker(
                    profileImage: profileImage,
                    onImagePicked: (file) {
                      setState(() {
                        profileImage = file;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ProfileTextField(label: "Name", controller: _nameController),
                  const SizedBox(height: 16),
                  ProfileTextField(label: "Bio", controller: _bioController),
                  const SizedBox(height: 16),
                  ProfileTextField(
                    label: "About",
                    controller: _personalDetailedController,
                  ),
                  const SizedBox(height: 16),
                  ProfileTextField(
                    label: "Address",
                    controller: _addressController,
                  ),
                  const SizedBox(height: 16),
                  PhoneInputField(
                    selectedCountry: selectedCountry,
                    phoneController: _phoneController,
                    onCountrySelected: (country) {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  SaveButton(
                    nameController: _nameController,
                    bioController: _bioController,
                    addressController: _addressController,
                    personalController: _personalDetailedController,
                    phoneController: _phoneController,
                    selectedCountry: selectedCountry,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
