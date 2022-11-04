import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

showAlertDialog({
  required BuildContext context,
  required String continueText,
  required String cancelText,
  required String title,
  required String description,
  required VoidCallback continueFunc,
  String? confirmText,
}) {
  Widget cancelButton = OutlinedButton(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(color: primaryColor, width: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      cancelText,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        color: primaryColor,
        fontSize: 16,
      ),
    ),
  );

  Widget continueButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
    ),
    onPressed: () => continueFunc(),
    child: Text(
      continueText,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    titlePadding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.urbanist(
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    ),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    content: IntrinsicHeight(
      child: Column(
        children: [
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          if (confirmText != null)
            Text(
              confirmText,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.8),
                fontSize: 18,
              ),
            ),
          const Divider(
            color: greyTextColor,
            thickness: 0.6,
            endIndent: 1,
            indent: 1,
          ),
        ],
      ),
    ),
    actionsPadding: const EdgeInsets.only(top: 0, bottom: 8),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
