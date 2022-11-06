import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final bool isEmail;
  final String isConfirmPass;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    required this.label,
    this.isEmail = false,
    this.isConfirmPass = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: progressBackgroundColor),
      borderRadius: BorderRadius.circular(12),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          style: GoogleFonts.urbanist(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: redIconColor),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          keyboardType: textInputType,
          obscureText: isPass,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter value';
            }

            if (isEmail) {
              final emailRegExp =
                  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              return emailRegExp.hasMatch(value)
                  ? null
                  : 'Please enter valid email';
            }

            if (isConfirmPass.isNotEmpty) {
              return isConfirmPass == value ? null : 'Password not match';
            }

            return null;
          },
        ),
      ],
    );
  }
}
