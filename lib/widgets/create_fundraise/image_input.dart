import 'package:charity_app/utils/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageInput extends StatelessWidget {
  final Uint8List? imageFile;
  final double width;
  final String? inputType;
  final VoidCallback selectImage;
  final bool isError;

  const ImageInput({
    super.key,
    required this.imageFile,
    required this.width,
    required this.selectImage,
    this.inputType,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: isError && imageFile == null ? Colors.red : imageInputBorderColor,
      strokeWidth: 2,
      dashPattern: const [8, 6],
      radius: const Radius.circular(8),
      padding: const EdgeInsets.all(1),
      child: AspectRatio(
        aspectRatio: inputType == 'cover' ? 2.2 : 1,
        child: InkWell(
          onTap: selectImage,
          child: Container(
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: imageFile != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '+',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: isError && imageFile == null
                            ? Colors.red
                            : primaryColor,
                      ),
                      children: [
                        if (inputType == 'cover')
                          TextSpan(
                            text: '\nAdd Cover Photos',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: paginationColor,
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
