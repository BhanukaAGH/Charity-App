import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldDropDown extends StatefulWidget {
  final String label;
  final String hintText;
  final bool withAsterisk;

  const FormFieldDropDown({
    super.key,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
  });

  @override
  State<FormFieldDropDown> createState() => _FormFieldDropDownState();
}

class _FormFieldDropDownState extends State<FormFieldDropDown> {
  String? _selectValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: greyTextColor,
              ),
              children: [
                TextSpan(
                  text: widget.withAsterisk ? ' *' : '',
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
                value: _selectValue,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 12),
                  hintText: '   ${widget.hintText}',
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
                onChanged: (String? value) {
                  setState(() {
                    _selectValue = value!;
                  });
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
