import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/register_cubit/register_cubit.dart';
import 'package:jobsque/features/auth/presentation/views/create_account_bottom_section.dart';
import 'package:jobsque/features/auth/presentation/views/create_account_form_section.dart';

class CreateAccountContent extends StatefulWidget {
  const CreateAccountContent({super.key});

  @override
  State<CreateAccountContent> createState() => _CreateAccountContentState();
}

class _CreateAccountContentState extends State<CreateAccountContent> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isPasswordObscure = true;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void onCreateAccountPressed() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final userName = userNameController.text.trim();
      final password = passwordController.text;
      log('Email: $email, Password: $password, userName: $userName');
      context.read<RegisterCubit>().register(
        name: userName,
        email: email,
        password: password,
      );
    }
  }

  Future<void> handleRegisterSuccess(RegisterSuccess state) async {
    Navigator.pop(context); // Close loading dialog

    final prefs = sl<AppPreferences>();
    await prefs.setToken(state.registerModel.token);
    await prefs.setUserName(state.registerModel.profile.name);
    await prefs.setUserEmail(state.registerModel.profile.email);

    if (!mounted) return;

    GoRouter.of(
      context,
    ).pushReplacement(AppRouter.kCreateAccountCustomizationView);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegisterSuccess) {
          handleRegisterSuccess(state);
        } else if (state is RegisterFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CreateAccountFormSection(
              userNameController: userNameController,
              passwordController: passwordController,
              isPasswordObscure: isPasswordObscure,
              togglePasswordVisibility: togglePasswordVisibility,
              emailController: emailController,
            ),
            const Spacer(),
            CreateAccountBottomSection(
              onCreateAccountPressed: onCreateAccountPressed,
            ),
          ],
        ),
      ),
    );
  }
}
