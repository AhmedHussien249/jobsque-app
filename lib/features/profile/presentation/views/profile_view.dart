import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_cubit.dart';
import 'package:jobsque/features/profile/presentation/view_model/cubits/edit_profile_cubit/profile_state.dart';
import 'package:jobsque/features/profile/presentation/views/edit_profile_view.dart';
import 'package:jobsque/features/profile/presentation/views/login_and_security_view.dart';
import 'package:jobsque/features/profile/presentation/views/portfolio_view.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_about_section.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_header.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_menu_section.dart';
import 'package:jobsque/features/profile/presentation/widgets/profile_stats.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              context.read<ProfileCubit>().getPortfolio();
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetPortfolioLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetPortfolioFailure) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is GetPortfolioSuccess) {
                final profile = state.data.profile;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileAppBar(),
                      const SizedBox(height: 12),
                      ProfileHeader(profile: profile),
                      const SizedBox(height: 20),
                      ProfileStats(),
                      const SizedBox(height: 20),
                      AboutSection(profile: profile),
                      const SizedBox(height: 20),
                      MenuSection(
                        title: "General",
                        items: [
                          MenuItemData(
                            iconUrl: AppAssets.editProfile,
                            text: "Edit Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EditProfileView(),
                                ),
                              );
                            },
                          ),
                          MenuItemData(
                            iconUrl: AppAssets.portfolio,
                            text: "Portfolio",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PortfolioView(),
                                ),
                              );
                            },
                          ),
                          MenuItemData(
                            iconUrl: AppAssets.language,
                            text: "Language",
                          ),
                          MenuItemData(
                            iconUrl: AppAssets.notification2,
                            text: "Notification",
                          ),
                          MenuItemData(
                            iconUrl: AppAssets.loginAndSecurity,
                            text: "Login and security",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginAndSecurityView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      MenuSection(
                        title: "Others",
                        items: [
                          MenuItemData(text: "Accessibility"),
                          MenuItemData(text: "Help Center"),
                          MenuItemData(text: "Terms & Conditions"),
                          MenuItemData(text: "Privacy Policy"),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
