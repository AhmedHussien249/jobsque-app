import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/storage/app_preferences.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/service_locator.dart';
import 'package:jobsque/features/auth/presentation/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:jobsque/features/auth/presentation/widgets/login_bottom_section.dart';
import 'package:jobsque/features/auth/presentation/widgets/login_form_section.dart';

class LoginBodyContent extends StatefulWidget {
  const LoginBodyContent({super.key});

  @override
  State<LoginBodyContent> createState() => _LoginBodyContentState();
}

class _LoginBodyContentState extends State<LoginBodyContent> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isRememberMeChecked = false;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void onLoginPressed() {
    if (formKey.currentState!.validate()) {
      final email = userNameController.text.trim();
      final password = passwordController.text;
      log('UserName: $email, Password: $password');
      context.read<LoginCubit>().login(
        email: email,
        password: password,
        rememberMe: isRememberMeChecked,
      );
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // show loading indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccess) {
          final prefs = sl<AppPreferences>();
          final token = prefs.getToken();
          final email = prefs.getUserEmail();
          final remember = prefs.isRemembered();

          print('🔐 Token: $token');
          print('📧 Email: $email');
          print('✅ Remember Me: $remember');

          GoRouter.of(
            context,
          ).pushReplacement(AppRouter.kHomeView); // Close the dialog
          // Navigate to home or next page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome ${state.user.name}!')),
          );
        } else if (state is LoginFailure) {
          Navigator.pop(context); // Close the dialog
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            LoginFormSection(
              userNameController: userNameController,
              passwordController: passwordController,
              isPasswordObscure: isPasswordObscure,
              isRememberMeChecked: isRememberMeChecked,
              togglePasswordVisibility: togglePasswordVisibility,
              onRememberMeChanged: (value) {
                setState(() {
                  isRememberMeChecked = value;
                });
              },
            ),
            const Spacer(),
            LoginBottomSection(onLoginPressed: onLoginPressed),
          ],
        ),
      ),
    );
  }
}
