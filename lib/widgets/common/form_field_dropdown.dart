import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldDropDown extends StatelessWidget {
  final String label;
  final String hintText;
  final bool withAsterisk;
  final String? selectValue;
  final Function(String?) onChanged;

  const FormFieldDropDown({
    super.key,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
    required this.selectValue,
    required this.onChanged,
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
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                value: selectValue,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 12),
                  hintText: '   $hintText',
                  hintStyle: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: imageInputBorderColor,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: progressBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
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
                ),
                items: categories
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
                validator: (value) {
                  if (withAsterisk && value == null) {
                    return 'Please enter a $hintText.';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List categories = ['Education', 'Medical', 'Emergency'];
