import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FormFieldDateInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool withAsterisk;

  const FormFieldDateInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
  });

  @override
  State<FormFieldDateInput> createState() => _FormFieldDateInputState();
}

class _FormFieldDateInputState extends State<FormFieldDateInput> {
  @override
  void initState() {
    widget.controller.text = "";
    super.initState();
  }

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
          TextFormField(
            controller: widget.controller,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              hintText: widget.hintText,
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
              suffixIcon: const Icon(Icons.date_range),
            ),
            textInputAction: TextInputAction.next,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  widget.controller.text = formattedDate;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
