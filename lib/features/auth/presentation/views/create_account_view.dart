import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_assets.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/presentation/widgets/auth_custom_app_bar.dart';
import 'package:jobsque/features/auth/presentation/widgets/social_button.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: CreateAccountContent(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
      GoRouter.of(context).pushReplacement(AppRouter.kCreateAccountCustomizationView);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // الجزء العلوي من الشاشة
          CreateAccountFormSection(
            userNameController: userNameController,
            passwordController: passwordController,
            isPasswordObscure: isPasswordObscure,
            togglePasswordVisibility: togglePasswordVisibility,
            emailController: emailController,
            
          ),
          // Spacer علشان يفصل الجزء العلوي عن الزرار
          const Spacer(),

          // الجزء السفلي الثابت
          CreateAccountBottomSection(onCreateAccountPressed: onCreateAccountPressed),
        ],
      ),
    );
  }
}

class CreateAccountFormSection extends StatelessWidget {
  const CreateAccountFormSection({
    super.key,
    required this.userNameController,
    required this.passwordController,
    required this.isPasswordObscure,
    required this.togglePasswordVisibility,
    required this.emailController,
  });
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordObscure;
  final VoidCallback togglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: true),
        const SizedBox(height: 44),
        Text(AppStrings.createAccount, style: AppStyles.medium28),
        const SizedBox(height: 8),
        Text(AppStrings.createAccountSubtitle, style: AppStyles.regular14),
        const SizedBox(height: 44),
        CustomTextFormField(
          controller: userNameController,
          hint: AppStrings.userName,
          prefixIcon: const Icon(
            Icons.person_2_outlined,
            color: Color(0xff292D32),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: emailController,
          hint: 'email',
          prefixIcon: const Icon(
            FontAwesomeIcons.envelope,
            color: Color(0xff292D32),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: passwordController,
          hint: 'Password',
          isPassword: true,
          obscureText: isPasswordObscure,
          onSuffixTap: togglePasswordVisibility,
          prefixIcon: const Icon(Icons.lock_outline),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.passMustBe,
          style: AppStyles.regular14.copyWith(color: const Color(0xff6B7280)),
        ),
      ],
    );
  }
}

class CreateAccountBottomSection extends StatelessWidget {
  const CreateAccountBottomSection({
    super.key,
    required this.onCreateAccountPressed,
  });
  final VoidCallback onCreateAccountPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.alreadyHaveAcc,
              style: AppStyles.medium14.copyWith(
                color: const Color(0xff9CA3AF),
              ),
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: Text(
                '  Login',
                style: AppStyles.regular14.copyWith(
                  color: const Color(0xff3366FF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Center(
          child: CustomButton(
            text: 'Create account',
            onPressed: onCreateAccountPressed,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 64.5, height: 1, color: const Color(0xffD1D5DB)),
            const SizedBox(width: 25),
            Text(
              AppStrings.orSignUpWith,
              style: AppStyles.regular14.copyWith(
                color: const Color(0xff6B7280),
              ),
            ),
            const SizedBox(width: 25),
            Container(width: 64.5, height: 1, color: const Color(0xffD1D5DB)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(asset: AppAssets.google, label: AppStrings.google),
            const SizedBox(width: 16),
            SocialButton(asset: AppAssets.facebook, label: AppStrings.facebook),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
