import 'package:flutter/material.dart';
import 'package:joblink/core/utils/app_assets.dart';
import 'package:joblink/core/utils/app_strings.dart';
import 'package:joblink/core/utils/app_styles.dart';
import 'package:joblink/core/widgets/custom_button.dart';
import 'package:joblink/core/widgets/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: LoignViewBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoignViewBody extends StatefulWidget {
  const LoignViewBody({super.key});

  @override
  State<LoignViewBody> createState() => _LoignViewBodyState();
}

class _LoignViewBodyState extends State<LoignViewBody> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordObscure = true;
  final formKey = GlobalKey<FormState>();
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
      // TODO: Send to ViewModel or Auth Logic
      print('Email: $email, Password: $password');
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

      slivers: [
        SliverToBoxAdapter(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthCustomAppBar(hasBackButton: false),
                SizedBox(height: 44),
                Text(AppStrings.login, style: AppStyles.medium28),
                SizedBox(height: 8),
                Text(AppStrings.orSignUpWith, style: AppStyles.regular14),
                SizedBox(height: 8),
                Text(AppStrings.loginSubtitle, style: AppStyles.regular16),
                SizedBox(height: 44),
                CustomTextFormField(
                  controller: userNameController,
                  hint: AppStrings.userName,
                  prefixIcon: Icon(
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
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: passwordController,
                  label: 'Password',
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isRememberMeChecked,
                          onChanged: (value) {
                            setState(() {
                              isRememberMeChecked = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          activeColor: Color(
                            0xff3366FF,
                          ), // غيّره حسب لون المشروع
                        ),
                        Text('Remember Me', style: AppStyles.regular14),
                      ],
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: AppStyles.regular14.copyWith(
                          color: Color(0xff3366FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.dontHaveAcc,
                    style: AppStyles.medium14.copyWith(
                      color: Color(0xff9CA3AF),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '  Register',
                      style: AppStyles.regular14.copyWith(
                        color: Color(0xff3366FF),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: CustomButton(text: 'Login', onPressed: onLoginPressed),
              ),
              SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(width: 70.5, height: 1, color: Color(0xffD1D5DB)),
                  SizedBox(width: 25),
                  Text(
                    AppStrings.orLoginWith,
                    style: AppStyles.regular14.copyWith(
                      color: Color(0xff6B7280),
                    ),
                  ),
                  SizedBox(width: 25),
                  Container(width: 70.5, height: 1, color: Color(0xffD1D5DB)),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 154,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffD1D5DB)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Image.asset(AppAssets.google, height: 16, width: 16),
                        SizedBox(width: 2),
                        Text(
                          AppStrings.google,
                          style: AppStyles.medium14.copyWith(
                            color: (Color(0xff363F5E)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 154,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xffD1D5DB)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Image.asset(AppAssets.facebook, height: 16, width: 16),
                        SizedBox(width: 2),
                        Text(
                          AppStrings.facebook,
                          style: AppStyles.medium14.copyWith(
                            color: (Color(0xff363F5E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AuthCustomAppBar extends StatelessWidget {
  const AuthCustomAppBar({super.key, required this.hasBackButton});
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        hasBackButton
            ? InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff292D32),
                ),
              )
            : const Spacer(),

        Image.asset(AppAssets.logo, height: 19, width: 81),
      ],
    );
  }
}
