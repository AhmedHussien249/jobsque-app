import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_text_form_field.dart';
import 'package:jobsque/features/auth/presentation/widgets/auth_custom_app_bar.dart';

class ForgetPasswordFormSection extends StatelessWidget {
  const ForgetPasswordFormSection({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCustomAppBar(hasBackButton: true),
        SizedBox(height: 39),
        Text(
          AppStrings.resetPassword,
          style: AppStyles.medium28.copyWith(color: const Color(0xff111827)),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.forgetPasswordSubtitle,
          style: AppStyles.regular16.copyWith(color: const Color(0xff6B7280)),
        ),
        SizedBox(height: 40),
        CustomTextFormField(
          controller: emailController,
          hint: 'email',
          prefixIcon: Icon(FontAwesomeIcons.envelope),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
      ],
    );
  }
}
