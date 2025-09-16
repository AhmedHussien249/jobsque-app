import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_cubit.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_state.dart';

class ProfileImagePicker extends StatefulWidget {
  final File? profileImage;
  final ValueChanged<File> onImagePicked;
  const ProfileImagePicker({
    super.key,
    this.profileImage,
    required this.onImagePicked,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourcePicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (modalContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pick from Gallery"),
                onTap: () async {
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (!mounted) return;
                  Navigator.pop(modalContext);
                  if (pickedFile != null) {
                    final file = File(pickedFile.path);
                    widget.onImagePicked(file);
                    context.read<ProfileCubit>().updateProfileImage(file.path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () async {
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (!mounted) return;
                  Navigator.pop(modalContext);
                  if (pickedFile != null) {
                    final file = File(pickedFile.path);
                    widget.onImagePicked(file);
                    context.read<ProfileCubit>().updateProfileImage(
                      pickedFile.path,
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (widget.profileImage != null) {
      imageProvider = FileImage(widget.profileImage!);
    } else if (context.read<ProfileCubit>().state is UpdateProfileImage) {
      imageProvider = FileImage(
        File(
          (context.read<ProfileCubit>().state as UpdateProfileImage).imagePath,
        ),
      );
    } else {
      imageProvider = const AssetImage("assets/images/avatar.png");
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color.fromARGB(255, 210, 209, 209),
              backgroundImage: imageProvider,
            ),
            Center(
              child: InkWell(
                onTap: _showImageSourcePicker,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    "assets/icons/camera.svg",
                    colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showImageSourcePicker,
          child: const Text(
            "Change Photo",
            style: TextStyle(color: Color(0XFF3366FF), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
