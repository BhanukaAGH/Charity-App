import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool withAsterisk;
  final TextInputType textInputType;
  final Icon? suffixIcon;

  const FormFieldInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
    required this.textInputType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: greyTextColor,
              ),
              children: [
                TextSpan(
                  text: withAsterisk ? ' *' : '',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: imageInputBorderColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: progressBackgroundColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: suffixIcon,
            ),
            textInputAction: TextInputAction.next,
            keyboardType: textInputType,
            validator: (value) {
              if (withAsterisk && value!.isEmpty) {
                return 'Please enter a $hintText.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
