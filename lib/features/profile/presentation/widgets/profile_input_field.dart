
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final Country? selectedCountry;
  final TextEditingController phoneController;
  final ValueChanged<Country> onCountrySelected;

  const PhoneInputField({
    super.key,
    this.selectedCountry,
    required this.phoneController,
    required this.onCountrySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mobile",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0XFF9CA3AF)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: onCountrySelected,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        selectedCountry?.flagEmoji ?? "🇪🇬",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                ),
              ),
              Container(height: 40, width: 1, color: const Color(0XFF9CA3AF)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "123 456 789",
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty
                            ? "Please enter your mobile number"
                            : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}