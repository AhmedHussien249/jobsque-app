import 'package:flutter/material.dart';
import 'package:jobsque/core/utils/app_strings.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/features/auth/presentation/widgets/selectable_items_sliver_grid.dart';

class CreateAccountCustomizationView extends StatefulWidget {
  const CreateAccountCustomizationView({super.key});

  @override
  State<CreateAccountCustomizationView> createState() =>
      _CreateAccountCustomizationViewState();
}

class _CreateAccountCustomizationViewState
    extends State<CreateAccountCustomizationView> {
  // Default selected (can be empty)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
                child: Column(
                  children: [
                    Text(AppStrings.typeOfWork, style: AppStyles.medium24),
                    SizedBox(height: 12),
                    Text(
                      AppStrings.tellUs,
                      style: AppStyles.regular16.copyWith(
                        color: const Color(0xff737379),
                      ),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.only(right: 24, left: 24, bottom: 66),
              sliver: SelectableItemSliverGrid(),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomButton(
                  onPressed: () {
                    // Proceed to next step
                  },

                  text: 'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

