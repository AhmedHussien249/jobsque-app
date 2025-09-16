import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
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

  /// دالة لقص/تعديل الصورة بعد اختيارها
  Future<File?> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 90,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // مربعة للبروفايل
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Photo',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: false,
          lockAspectRatio: true, // نخليها مربعة بس
        ),
        IOSUiSettings(
          title: 'Edit Photo',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (!mounted) return;
    Navigator.pop(context);

    if (pickedFile != null) {
      final croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        widget.onImagePicked(croppedFile);
        context.read<ProfileCubit>().updateProfileImage(croppedFile.path);
      }
    }
  }

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
                onTap: () => _pickImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () => _pickImage(ImageSource.camera),
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
        File((context.read<ProfileCubit>().state as UpdateProfileImage).imagePath),
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
                    colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
            style: TextStyle(
              color: Color(0XFF3366FF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
