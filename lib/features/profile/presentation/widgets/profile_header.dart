
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_cubit.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final dynamic profile; // ضع النوع الصحيح إذا معروف
  const ProfileHeader({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            String? profileImagePath;
            if (state is UpdateProfileImage) {
              profileImagePath = state.imagePath;
            } else {
              profileImagePath =
                  sl<AppPreferences>().getProfileImage();
            }

            return CircleAvatar(
              radius: 40,
              backgroundColor:
                  const Color.fromARGB(255, 210, 209, 209),
              backgroundImage: profileImagePath != null &&
                      profileImagePath.isNotEmpty
                  ? FileImage(File(profileImagePath))
                  : const AssetImage("assets/images/avatar.png")
                      as ImageProvider,
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          profile?.name ?? "No Name",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          profile?.bio ?? "No bio",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}