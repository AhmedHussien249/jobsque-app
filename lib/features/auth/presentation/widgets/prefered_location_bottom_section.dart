import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/utils/app_router.dart';
import 'package:jobsque/core/utils/app_styles.dart';
import 'package:jobsque/core/widgets/custom_button.dart';
import 'package:jobsque/features/auth/data/models/country_model.dart';

class PreferedLocationButtomSection extends StatefulWidget {
  const PreferedLocationButtomSection({super.key});

  @override
  State<PreferedLocationButtomSection> createState() =>
      _PreferedLocationButtomSectionState();
}

class _PreferedLocationButtomSectionState
    extends State<PreferedLocationButtomSection> {
  Set<int> selectedCountries = {0};
  final allCountries = CountryModel.countries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(allCountries.length, (index) {
              final country = allCountries[index];
              final selected = selectedCountries.contains(index);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selected) {
                      selectedCountries.remove(index);
                    } else {
                      selectedCountries.add(index);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xffD6E4FF) : Colors.white,
                    border: Border.all(
                      color: selected
                          ? const Color(0xffD6E4FF)
                          : Colors.grey.shade300,
                      width: 1.3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      Text(
                        country.name,
                        style: AppStyles.regular16.copyWith(
                          color: selected
                              ? const Color(0xFF11182E)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 63),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                log(
                  "Selected: ${selectedCountries.map((i) => CountryModel.countries[i].name).toList()}",
                );
                GoRouter.of(context).push(AppRouter.kYourAccountHasBeenSetUp);
              },

              text: 'Next',
            ),
          ),
        ),
      ],
    );
  }
}
