import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final double width;
  String? inputType = '';

  ImageInput({
    super.key,
    required this.width,
    this.inputType,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Create a Fundraise',
            textAlign: TextAlign.center,
          ),
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    semanticLabel: 'Camera',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.collections_outlined,
                    semanticLabel: 'Gallery',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _file = file;
                    });
                  },
                ),
              ],
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: imageInputBorderColor,
      strokeWidth: 2,
      dashPattern: const [8, 6],
      radius: const Radius.circular(8),
      padding: const EdgeInsets.all(1),
      child: AspectRatio(
        aspectRatio: widget.inputType == 'cover' ? 2.2 : 1,
        child: InkWell(
          onTap: () => _selectImage(context),
          child: Container(
            width: widget.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _file != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
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
                        color: primaryColor,
                      ),
                      children: [
                        if (widget.inputType == 'cover')
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
